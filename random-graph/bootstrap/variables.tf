# ---------------------------------------------------------------------------
# HCP Terraform connection
#
# Authentication for the tfe provider comes from the TFE_TOKEN environment
# variable, which you set as a SENSITIVE env var on the bootstrap workspace.
# ---------------------------------------------------------------------------
variable "tfe_organization" {
  type        = string
  description = "HCP Terraform organization name that will own the workspaces."
}

variable "tfe_hostname" {
  type        = string
  description = "HCP Terraform / Terraform Enterprise hostname."
  default     = "app.terraform.io"
}

# ---------------------------------------------------------------------------
# VCS connection (the child workspaces are VCS-driven against this same repo)
# ---------------------------------------------------------------------------
variable "vcs_repo_identifier" {
  type        = string
  description = "The repo holding this config, in <org>/<repo> form (e.g. you/terraform-tests)."
}

variable "vcs_oauth_token_id" {
  type        = string
  description = "OAuth token ID of the HCP Terraform VCS connection (ot-xxxx). Set this OR vcs_github_app_installation_id."
  default     = ""
}

variable "vcs_github_app_installation_id" {
  type        = string
  description = "GitHub App installation ID (ghain-xxxx). Set this OR vcs_oauth_token_id."
  default     = ""
}

variable "vcs_branch" {
  type        = string
  description = "Branch HCP Terraform watches. Empty uses the repo default branch."
  default     = ""
}

variable "repo_subpath" {
  type        = string
  description = <<-EOT
    Path within the repo to this random-graph config (the directory containing
    bootstrap/, modules/, workspaces/). Child working directories become
    "<repo_subpath>/workspaces/<role>". Use "" if this config is at the repo root.
  EOT
  default     = "random-graph"
}

# ---------------------------------------------------------------------------
# Naming / placement
# ---------------------------------------------------------------------------
variable "workspace_prefix" {
  type        = string
  description = "Prefix for every child workspace name, e.g. <prefix>-foundation."
  default     = "random-graph"
}

variable "project_id" {
  type        = string
  description = "Existing HCP Terraform project ID to place workspaces in. Leave empty to use project_name or the org default."
  default     = ""
}

variable "project_name" {
  type        = string
  description = "If set (and project_id is empty), a project with this name is created and used."
  default     = ""
}

variable "extra_tags" {
  type        = list(string)
  description = "Additional tag names applied to every child workspace."
  default     = []
}

# ---------------------------------------------------------------------------
# Child workspace behaviour
# ---------------------------------------------------------------------------
variable "execution_mode" {
  type        = string
  description = "Workspace execution mode: remote, agent, or local."
  default     = "remote"

  validation {
    condition     = contains(["remote", "agent", "local"], var.execution_mode)
    error_message = "execution_mode must be one of: remote, agent, local."
  }
}

variable "agent_pool_id" {
  type        = string
  description = "Agent pool ID, required when execution_mode = agent."
  default     = ""
}

variable "auto_apply" {
  type        = bool
  description = "Auto-apply successful plans so run-trigger cascades flow without manual approval."
  default     = true
}

variable "queue_all_runs" {
  type        = bool
  description = "Queue a run immediately when a child workspace is first created. Keep false so the initial cascade can start cleanly from foundation."
  default     = false
}

variable "terraform_version" {
  type        = string
  description = "Terraform version for the child workspaces. Empty lets HCP Terraform choose the latest."
  default     = ""
}

variable "global_remote_state" {
  type        = bool
  description = "Allow every workspace in the org to read these workspaces' state, so the terraform_remote_state DAG works."
  default     = true
}
