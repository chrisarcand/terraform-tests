terraform {
  required_version = ">= 1.5.0"

  # Provider constraints intentionally vary per workspace so the
  # provider/version views show variety. In-memory providers only.
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.11"
    }
  }
}
