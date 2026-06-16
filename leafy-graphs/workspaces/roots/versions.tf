terraform {
  required_version = ">= 1.5.0"

  # Provider versions are pinned to EXACT versions (and intentionally
  # differ across workspaces) so the provider-version views show a real
  # distribution. In-memory providers only.
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.2"
    }
  }
}
