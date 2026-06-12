variable "tfe_organization" {
  type        = string
  description = "HCP Terraform org (injected as a workspace variable)."
  default     = ""
}

variable "tfe_hostname" {
  type        = string
  description = "HCP Terraform hostname (injected as a workspace variable)."
  default     = "app.terraform.io"
}

variable "workspace_prefix" {
  type        = string
  description = "Workspace name prefix (injected as a workspace variable)."
  default     = "leafy"
}
