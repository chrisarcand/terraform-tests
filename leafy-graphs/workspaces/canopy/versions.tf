terraform {
  required_version = ">= 1.7.0"

  # Provider constraints intentionally vary per workspace so the
  # provider/version views show variety. In-memory providers only.
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.11.0"
    }
  }
}
