terraform {
  required_version = ">= 1.6.0"

  required_providers {
    # Broad constraints; each workspace root narrows them so the provider map
    # shows per-workspace variety. random_bytes requires
    # the random provider >= 3.5.0.
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.4.0"
    }
  }
}
