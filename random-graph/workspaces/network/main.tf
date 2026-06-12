provider "random" {}
provider "null" {}
provider "tls" {}

# network consumes foundation's outputs. Reading them via terraform_remote_state
# creates an explicit dependency on the foundation workspace
# (a foundation -> network edge in the dependency graph).
data "terraform_remote_state" "foundation" {
  backend = "remote"

  config = {
    hostname     = var.tfe_hostname
    organization = var.tfe_organization
    workspaces = {
      name = "${var.workspace_prefix}-foundation"
    }
  }
}

module "graph" {
  source      = "../../modules/random_graph"
  name_prefix = "${var.workspace_prefix}-network"

  upstream = {
    foundation_seed = data.terraform_remote_state.foundation.outputs.primary_seed
    foundation_pet  = data.terraform_remote_state.foundation.outputs.pet_name
  }
}
