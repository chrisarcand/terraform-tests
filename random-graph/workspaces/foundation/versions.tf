terraform {
  required_version = ">= 1.6.0"

  # Provider version constraints are intentionally DIFFERENT in each workspace
  # so the provider/version views show variety.
  # foundation: pessimistic patch pin on random.
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.0"
    }
  }
}
