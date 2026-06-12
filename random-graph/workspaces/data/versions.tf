terraform {
  required_version = ">= 1.6.0"

  # data: exact pin on random (distinct from foundation's "~> 3.6.0" and
  # network's range) so there's a third provider-version style across workspaces.
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.0, < 4.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
