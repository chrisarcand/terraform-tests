locals {
  # ---------------------------------------------------------------------------
  # The cross-workspace dependency graph.
  #
  #   foundation ──> network ──┐
  #       │                    ├──> platform ──> app
  #       ├────────> data ─────┘
  #       └────────> pets   (random_pet-only, 10-layer binary tree)
  #
  # Each entry maps a workspace role to the roles whose outputs it consumes via
  # terraform_remote_state. The same edges are turned into tfe_run_trigger
  # resources below so an apply cascades downstream automatically.
  # ---------------------------------------------------------------------------
  topology = {
    foundation = []
    network    = ["foundation"]
    data       = ["foundation"]
    platform   = ["network", "data"]
    app        = ["platform"]
    pets       = ["foundation"]
  }

  # producer -> consumer pairs, flattened for tfe_run_trigger.
  edge_list = flatten([
    for consumer, producers in local.topology : [
      for producer in producers : {
        consumer = consumer
        producer = producer
      }
    ]
  ])
  edges = [for e in local.edge_list : "${e.producer} -> ${e.consumer}"]

  # Repo layout. Child working dirs are "<repo_subpath>/workspaces/<role>";
  # a change anywhere under "<repo_subpath>/modules" retriggers every workspace.
  path_prefix    = var.repo_subpath != "" ? "${var.repo_subpath}/" : ""
  modules_prefix = "${local.path_prefix}modules"
  working_directories = {
    for role in keys(local.topology) : role => "${local.path_prefix}workspaces/${role}"
  }

  project_id = var.project_id != "" ? var.project_id : (
    var.project_name != "" ? tfe_project.this[0].id : null
  )
}

# Optionally create a project to hold the workspaces.
resource "tfe_project" "this" {
  count = var.project_name != "" && var.project_id == "" ? 1 : 0

  organization = var.tfe_organization
  name         = var.project_name
}

# ---------------------------------------------------------------------------
# One VCS-driven workspace per role. All workspaces point at the SAME repo but
# a different working_directory, so HCP Terraform clones the whole tree (the
# shared ../../modules/* resolve) and plans the role's subdirectory. Module
# changes retrigger every workspace via trigger_prefixes.
# ---------------------------------------------------------------------------
resource "tfe_workspace" "ws" {
  for_each = local.topology

  name         = "${var.workspace_prefix}-${each.key}"
  organization = var.tfe_organization
  project_id   = local.project_id

  description = "random-graph '${each.key}' workspace — ${length(each.value) == 0 ? "root (no upstreams)" : "consumes ${join(", ", each.value)}"}"

  execution_mode    = var.execution_mode
  agent_pool_id     = var.execution_mode == "agent" && var.agent_pool_id != "" ? var.agent_pool_id : null
  terraform_version = var.terraform_version != "" ? var.terraform_version : null

  auto_apply          = var.auto_apply
  global_remote_state = var.global_remote_state
  queue_all_runs      = var.queue_all_runs

  tag_names = concat(["random-graph", each.key], var.extra_tags)

  # Plan from this role's subdirectory; retrigger on shared module changes.
  working_directory     = local.working_directories[each.key]
  file_triggers_enabled = true
  trigger_prefixes      = [local.modules_prefix]

  dynamic "vcs_repo" {
    for_each = var.vcs_repo_identifier != "" ? [1] : []
    content {
      identifier                 = var.vcs_repo_identifier
      branch                     = var.vcs_branch != "" ? var.vcs_branch : null
      oauth_token_id             = var.vcs_oauth_token_id != "" ? var.vcs_oauth_token_id : null
      github_app_installation_id = var.vcs_github_app_installation_id != "" ? var.vcs_github_app_installation_id : null
    }
  }

  lifecycle {
    precondition {
      condition     = var.vcs_repo_identifier != ""
      error_message = "vcs_repo_identifier is required: these workspaces are VCS-driven."
    }
    precondition {
      condition     = (var.vcs_oauth_token_id != "") != (var.vcs_github_app_installation_id != "")
      error_message = "Set exactly one of vcs_oauth_token_id or vcs_github_app_installation_id."
    }
  }
}

# ---------------------------------------------------------------------------
# Run triggers wire the DAG: a successful apply in the producer queues a run in
# the consumer (auto-applied when auto_apply = true), so the whole graph
# cascades from foundation outward.
# ---------------------------------------------------------------------------
resource "tfe_run_trigger" "edges" {
  for_each = { for e in local.edge_list : "${e.producer}->${e.consumer}" => e }

  workspace_id  = tfe_workspace.ws[each.value.consumer].id # downstream, gets triggered
  sourceable_id = tfe_workspace.ws[each.value.producer].id # upstream apply is the source
}

# ---------------------------------------------------------------------------
# Inject the cross-workspace wiring values so each workspace's
# terraform_remote_state data sources can address their upstreams. This keeps
# the org name and prefix out of the committed configuration.
# ---------------------------------------------------------------------------
resource "tfe_variable" "tfe_organization" {
  for_each = local.topology

  workspace_id = tfe_workspace.ws[each.key].id
  key          = "tfe_organization"
  value        = var.tfe_organization
  category     = "terraform"
  description  = "Injected by bootstrap for terraform_remote_state addressing."
}

resource "tfe_variable" "tfe_hostname" {
  for_each = local.topology

  workspace_id = tfe_workspace.ws[each.key].id
  key          = "tfe_hostname"
  value        = var.tfe_hostname
  category     = "terraform"
  description  = "Injected by bootstrap for terraform_remote_state addressing."
}

resource "tfe_variable" "workspace_prefix" {
  for_each = local.topology

  workspace_id = tfe_workspace.ws[each.key].id
  key          = "workspace_prefix"
  value        = var.workspace_prefix
  category     = "terraform"
  description  = "Injected by bootstrap for terraform_remote_state addressing."
}
