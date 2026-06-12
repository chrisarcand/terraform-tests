provider "random" {}
provider "null" {}
provider "tls" {}

# app is the leaf of the main chain: it consumes platform (platform -> app edge).
data "terraform_remote_state" "platform" {
  backend = "remote"

  config = {
    hostname     = var.tfe_hostname
    organization = var.tfe_organization
    workspaces = {
      name = "${var.workspace_prefix}-platform"
    }
  }
}

module "graph" {
  source      = "../../modules/random_graph"
  name_prefix = "${var.workspace_prefix}-app"

  upstream = {
    platform_seed = data.terraform_remote_state.platform.outputs.primary_seed
  }
}
