terraform {
  required_version = ">= 1.6.0"

  # app: the most permissive constraints in the graph (lower bounds only). The
  # effective version still resolves to >= 3.5.0 because the random_graph module
  # requires random_bytes, but the declared style differs for variety.
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
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
