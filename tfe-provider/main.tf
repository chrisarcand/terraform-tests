provider "tfe" {
  hostname = var.hostname
  token    = var.token
}

variable "hostname" {
  type = string
  default = "app.terraform.io"
}

variable "token" {
  type = string
}

variable "organization" {
  type = string
}

resource "tfe_team" "test-1" {
  name         = "my-team-name"
  organization = var.organization
  visibility = "secret"
  organization_access {
    manage_policies = false
    manage_vcs_settings = false
    manage_workspaces = true
  }
}
