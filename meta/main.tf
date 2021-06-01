provider "tfe" {
  token = var.provider_token
}

variable "organization_name" {
  type = string
}

variable "provider_token" {
  type = string
}

variable "oauth_token_id" {
  type = string
}

variable "workspaces" {
  type = map(object({
    auto_apply = optional(bool)
    terraform_version = optional(string)
    execution_mode    = optional(string)
    allow_destroy_plan = optional(bool)
    working_directory = optional(string)
    file_triggers_enabled = optional(bool)
    trigger_prefixes = optional(list(string))
    vcs_repo          = optional(object({
      identifier = string
      oauth_token_id = optional(string)
      branch = optional(string)
      submodule_ingress = optional(bool)
    }))
  }))

  description = "This map of objects allows for simplified creation of a workspace with any resources that are always desired to be included with it."
}

resource "tfe_workspace" "workspaces" {
  for_each = var.workspaces

  name         = each.key
  organization = var.organization_name

  auto_apply        = each.value["auto_apply"]
  terraform_version = each.value["terraform_version"]
  execution_mode    = each.value["execution_mode"]
  working_directory = each.value["working_directory"] 
  dynamic "vcs_repo" {
    for_each = each.value.vcs_repo.*
    content {
      identifier     = vcs_repo.value["identifier"]
      oauth_token_id = var.oauth_token_id
      branch         = vcs_repo.value["branch"]
    }
  }
}

# As an example: This resource will create a variable sourced from the meta
# workspace created for each workspace in the workspaces map of objects- in this case,
# a token to use the TFE provider instantly in any workspace.
resource "tfe_variable" "provider_token" {
  for_each = var.workspaces

  workspace_id = tfe_workspace.workspaces[each.key].id
  key          = "provider_token"
  value        = var.provider_token
  category     = "terraform"
  sensitive    = true
  description = "TFE provider token, sourced from 'meta' workspace"
}
