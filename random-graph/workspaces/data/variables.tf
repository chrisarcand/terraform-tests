variable "tfe_organization" {
  type        = string
  description = "HCP Terraform org (injected by bootstrap as a workspace variable)."
  default     = ""
}

variable "tfe_hostname" {
  type        = string
  description = "HCP Terraform hostname (injected by bootstrap as a workspace variable)."
  default     = "app.terraform.io"
}

variable "workspace_prefix" {
  type        = string
  description = "Workspace name prefix (injected by bootstrap as a workspace variable)."
  default     = "random-graph"
}
