terraform {
  required_version = ">= 1.6.0"

  # pets: the ONLY workspace with a single provider (random). It builds a
  # 10-layer binary random_pet tree, so its provider map shows a
  # workspace with no null/tls at all.
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}
