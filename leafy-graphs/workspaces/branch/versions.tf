terraform {
  required_version = ">= 1.4.0"

  # Provider versions are pinned to EXACT versions (and intentionally
  # differ across workspaces) so the provider-version views show a real
  # distribution. In-memory providers only.
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}
