terraform {
  required_version = ">= 1.6.0"

  required_providers {
    # Intentionally broad here; the consuming workspace pins the exact
    # constraint so the provider map shows per-workspace variety.
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
  }
}
