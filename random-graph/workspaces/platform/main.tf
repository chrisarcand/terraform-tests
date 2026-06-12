provider "random" {}
provider "null" {}
provider "tls" {}

# platform sits at the join of the diamond: it consumes BOTH network and data,
# producing two inbound dependency edges (network -> platform, data -> platform).
data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    hostname     = var.tfe_hostname
    organization = var.tfe_organization
    workspaces = {
      name = "${var.workspace_prefix}-network"
    }
  }
}

data "terraform_remote_state" "data" {
  backend = "remote"

  config = {
    hostname     = var.tfe_hostname
    organization = var.tfe_organization
    workspaces = {
      name = "${var.workspace_prefix}-data"
    }
  }
}

module "graph" {
  source      = "../../modules/random_graph"
  name_prefix = "${var.workspace_prefix}-platform"

  upstream = {
    network_seed = data.terraform_remote_state.network.outputs.primary_seed
    data_seed    = data.terraform_remote_state.data.outputs.primary_seed
    data_pet     = data.terraform_remote_state.data.outputs.pet_name
  }
}
