provider "random" {}

# pets consumes foundation's seed (foundation -> pets edge) and weaves it into
# the root of a 10-layer binary random_pet tree (2^0 + 2^1 + ... + 2^9 = 1023
# pets). This workspace uses ONLY the random provider.
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

module "tree" {
  source      = "../../modules/pet_tree"
  name_prefix = "${var.workspace_prefix}-pets"

  branching       = 2
  layers          = 10
  max_layer_width = 0 # uncapped: a true 2^i-per-layer binary tree (1023 pets)

  root_seed = data.terraform_remote_state.foundation.outputs.primary_seed
}
