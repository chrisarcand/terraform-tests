terraform {
  required_version = ">= 1.6.0"

  # network: range constraint on random (no upper-major bound style differs
  # from foundation's pessimistic pin).
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 3.7.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }
}
