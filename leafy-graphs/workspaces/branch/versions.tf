terraform {
  required_version = ">= 1.4.0"

  # Provider constraints intentionally vary per workspace so the
  # provider/version views show variety. In-memory providers only.
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }
}
