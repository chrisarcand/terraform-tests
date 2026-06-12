terraform {
  required_version = ">= 1.6.0"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.58.0, < 1.0.0"
    }
  }

  # No backend block: this configuration runs in its own VCS-connected HCP
  # Terraform workspace ("<prefix>-bootstrap"), which you create once by hand.
  # HCP Terraform manages the state.
}

provider "tfe" {
  hostname = var.tfe_hostname
  # Authenticated by the TFE_TOKEN environment variable, set as a SENSITIVE
  # variable on the bootstrap workspace. Never hardcode the token here.
}
