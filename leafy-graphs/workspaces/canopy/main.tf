# ---------------------------------------------------------------------------
# leafy-graphs :: canopy
#
# An organic dependency graph made of SEVERAL INDEPENDENT pockets (no single
# root). Edges are implicit references within a pocket; pockets are not
# connected to each other -- mirroring how real configs form provider/
# resource clusters with multiple roots and leaves at varied depths.
#
# pockets: primary(37), time(4), password(1), random_null(10), random_null(7), random_null(10), lone(1)
# cross-workspace upstreams (remote_state): trunk, branch
# providers (all in-memory): null, random, time
# ---------------------------------------------------------------------------

provider "null" {}
provider "random" {}
provider "time" {}

data "terraform_remote_state" "trunk" {
  backend = "remote"
  config = {
    hostname     = var.tfe_hostname
    organization = var.tfe_organization
    workspaces = {
      name = "${var.workspace_prefix}-trunk"
    }
  }
}

data "terraform_remote_state" "branch" {
  backend = "remote"
  config = {
    hostname     = var.tfe_hostname
    organization = var.tfe_organization
    workspaces = {
      name = "${var.workspace_prefix}-branch"
    }
  }
}

locals {
  name_prefix = "${var.workspace_prefix}-canopy"
  upstream = {
    trunk_seed  = data.terraform_remote_state.trunk.outputs.primary_seed
    trunk_pet   = data.terraform_remote_state.trunk.outputs.pet_name
    branch_seed = data.terraform_remote_state.branch.outputs.primary_seed
    branch_pet  = data.terraform_remote_state.branch.outputs.pet_name
  }
}

# === pocket c0: primary random/null backbone -- the cross-workspace remote_state sink ===
resource "random_id" "c0_l0_0" {
  byte_length = 8
  keepers = merge({
    label = "${local.name_prefix}-c0_l0_0"
  }, local.upstream)
}
resource "random_pet" "c0_l0_1" {
  length    = 2
  separator = "-"
  keepers = {
    label = "${local.name_prefix}-c0_l0_1"
  }
}
resource "random_string" "c0_l0_2" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l0_2"
  }
}
resource "random_integer" "c0_l0_3" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l0_3"
  }
}
resource "null_resource" "c0_l1_0" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_0"
    p0    = random_id.c0_l0_0.hex
  }
}
resource "null_resource" "c0_l1_1" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_1"
    p0    = random_pet.c0_l0_1.id
  }
}
resource "null_resource" "c0_l1_2" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_2"
    p0    = random_string.c0_l0_2.result
  }
}
resource "random_string" "c0_l1_3" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l1_3"
    p0    = random_integer.c0_l0_3.id
    p1    = random_id.c0_l0_0.hex
  }
}
resource "random_string" "c0_l1_4" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l1_4"
    p0    = random_integer.c0_l0_3.id
    p1    = random_string.c0_l0_2.result
  }
}
resource "null_resource" "c0_l1_5" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_5"
    p0    = random_id.c0_l0_0.hex
    p1    = random_string.c0_l0_2.result
    p2    = random_pet.c0_l0_1.id
  }
}
resource "null_resource" "c0_l1_6" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_6"
    p0    = random_pet.c0_l0_1.id
    p1    = random_string.c0_l0_2.result
    p2    = random_id.c0_l0_0.hex
  }
}
resource "null_resource" "c0_l1_7" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_7"
    p0    = random_pet.c0_l0_1.id
    p1    = random_id.c0_l0_0.hex
  }
}
resource "null_resource" "c0_l2_0" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_0"
    p0    = null_resource.c0_l1_2.id
    p1    = null_resource.c0_l1_5.id
    p2    = null_resource.c0_l1_1.id
  }
}
resource "random_integer" "c0_l2_1" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l2_1"
    p0    = null_resource.c0_l1_1.id
    p1    = null_resource.c0_l1_6.id
  }
}
resource "null_resource" "c0_l2_2" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_2"
    p0    = random_string.c0_l1_4.result
  }
}
resource "null_resource" "c0_l2_3" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_3"
    p0    = null_resource.c0_l1_1.id
    p1    = null_resource.c0_l1_6.id
  }
}
resource "null_resource" "c0_l2_4" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_4"
    p0    = null_resource.c0_l1_6.id
    p1    = null_resource.c0_l1_0.id
  }
}
resource "null_resource" "c0_l2_5" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_5"
    p0    = null_resource.c0_l1_6.id
  }
}
resource "null_resource" "c0_l2_6" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_6"
    p0    = null_resource.c0_l1_0.id
  }
}
resource "null_resource" "c0_l3_0" {
  triggers = {
    label = "${local.name_prefix}-c0_l3_0"
    p0    = null_resource.c0_l1_2.id
    p1    = null_resource.c0_l2_4.id
  }
}
resource "null_resource" "c0_l3_1" {
  triggers = {
    label = "${local.name_prefix}-c0_l3_1"
    p0    = null_resource.c0_l2_4.id
    p1    = random_integer.c0_l2_1.id
  }
}
resource "null_resource" "c0_l3_2" {
  triggers = {
    label = "${local.name_prefix}-c0_l3_2"
    p0    = random_integer.c0_l2_1.id
    p1    = null_resource.c0_l2_6.id
  }
}
resource "null_resource" "c0_l3_3" {
  triggers = {
    label = "${local.name_prefix}-c0_l3_3"
    p0    = null_resource.c0_l2_6.id
    p1    = null_resource.c0_l2_3.id
    p2    = null_resource.c0_l2_4.id
  }
}
resource "random_integer" "c0_l3_4" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l3_4"
    p0    = null_resource.c0_l2_4.id
  }
}
resource "random_integer" "c0_l3_5" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l3_5"
    p0    = null_resource.c0_l2_4.id
    p1    = null_resource.c0_l2_5.id
  }
}
resource "random_integer" "c0_l3_6" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l3_6"
    p0    = null_resource.c0_l1_7.id
    p1    = random_id.c0_l0_0.hex
  }
}
resource "null_resource" "c0_l4_0" {
  triggers = {
    label = "${local.name_prefix}-c0_l4_0"
    p0    = random_integer.c0_l3_4.id
    p1    = random_id.c0_l0_0.hex
  }
}
resource "random_integer" "c0_l4_1" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l4_1"
    p0    = null_resource.c0_l3_3.id
    p1    = null_resource.c0_l3_0.id
  }
}
resource "random_string" "c0_l4_2" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l4_2"
    p0    = null_resource.c0_l2_4.id
    p1    = null_resource.c0_l3_3.id
  }
}
resource "random_string" "c0_l4_3" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l4_3"
    p0    = null_resource.c0_l2_3.id
    p1    = random_pet.c0_l0_1.id
  }
}
resource "random_pet" "c0_l4_4" {
  length    = 2
  separator = "-"
  keepers = {
    label = "${local.name_prefix}-c0_l4_4"
    p0    = random_integer.c0_l3_6.id
    p1    = null_resource.c0_l2_5.id
    p2    = null_resource.c0_l2_3.id
    p3    = random_string.c0_l0_2.result
  }
}
resource "null_resource" "c0_l4_5" {
  triggers = {
    label = "${local.name_prefix}-c0_l4_5"
    p0    = random_string.c0_l1_4.result
    p1    = null_resource.c0_l3_3.id
  }
}
resource "null_resource" "c0_l5_0" {
  triggers = {
    label = "${local.name_prefix}-c0_l5_0"
    p0    = null_resource.c0_l3_3.id
    p1    = random_id.c0_l0_0.hex
  }
}
resource "null_resource" "c0_l5_1" {
  triggers = {
    label = "${local.name_prefix}-c0_l5_1"
    p0    = null_resource.c0_l4_0.id
    p1    = null_resource.c0_l1_5.id
    p2    = random_id.c0_l0_0.hex
  }
}
resource "null_resource" "c0_l5_2" {
  triggers = {
    label = "${local.name_prefix}-c0_l5_2"
    p0    = random_pet.c0_l4_4.id
    p1    = null_resource.c0_l4_0.id
    p2    = null_resource.c0_l2_0.id
    p3    = random_id.c0_l0_0.hex
  }
}
resource "random_integer" "c0_l5_3" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l5_3"
    p0    = null_resource.c0_l2_2.id
    p1    = random_string.c0_l0_2.result
  }
}
resource "random_string" "c0_l5_4" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l5_4"
    p0    = null_resource.c0_l4_0.id
    p1    = random_string.c0_l4_3.result
  }
}

# === pocket c1: time pocket ===
resource "time_static" "c1_l0_0" {
}
resource "null_resource" "c1_l1_0" {
  triggers = {
    label = "${local.name_prefix}-c1_l1_0"
    p0    = time_static.c1_l0_0.id
  }
}
resource "null_resource" "c1_l1_1" {
  triggers = {
    label = "${local.name_prefix}-c1_l1_1"
    p0    = time_static.c1_l0_0.id
  }
}
resource "random_integer" "c1_l2_0" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c1_l2_0"
    p0    = null_resource.c1_l1_0.id
  }
}

# === pocket c2: isolated sensitive sink (random_password) ===
resource "random_password" "c2_l0_0" {
  length  = 24
  special = true
  keepers = {
    label = "${local.name_prefix}-c2_l0_0"
  }
}

# === pocket c3: independent random/null backbone ===
resource "random_string" "c3_l0_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c3_l0_0"
  }
}
resource "random_pet" "c3_l0_1" {
  length    = 2
  separator = "-"
  keepers = {
    label = "${local.name_prefix}-c3_l0_1"
  }
}
resource "null_resource" "c3_l1_0" {
  triggers = {
    label = "${local.name_prefix}-c3_l1_0"
    p0    = random_pet.c3_l0_1.id
    p1    = random_string.c3_l0_0.result
  }
}
resource "null_resource" "c3_l1_1" {
  triggers = {
    label = "${local.name_prefix}-c3_l1_1"
    p0    = random_string.c3_l0_0.result
    p1    = random_pet.c3_l0_1.id
  }
}
resource "null_resource" "c3_l1_2" {
  triggers = {
    label = "${local.name_prefix}-c3_l1_2"
    p0    = random_pet.c3_l0_1.id
  }
}
resource "null_resource" "c3_l1_3" {
  triggers = {
    label = "${local.name_prefix}-c3_l1_3"
    p0    = random_pet.c3_l0_1.id
    p1    = random_string.c3_l0_0.result
  }
}
resource "null_resource" "c3_l1_4" {
  triggers = {
    label = "${local.name_prefix}-c3_l1_4"
    p0    = random_pet.c3_l0_1.id
    p1    = random_string.c3_l0_0.result
  }
}
resource "null_resource" "c3_l1_5" {
  triggers = {
    label = "${local.name_prefix}-c3_l1_5"
    p0    = random_string.c3_l0_0.result
    p1    = random_pet.c3_l0_1.id
  }
}
resource "null_resource" "c3_l2_0" {
  triggers = {
    label = "${local.name_prefix}-c3_l2_0"
    p0    = null_resource.c3_l1_5.id
  }
}
resource "null_resource" "c3_l2_1" {
  triggers = {
    label = "${local.name_prefix}-c3_l2_1"
    p0    = null_resource.c3_l1_5.id
    p1    = null_resource.c3_l1_0.id
    p2    = null_resource.c3_l1_4.id
  }
}

# === pocket c4: independent random/null backbone ===
resource "random_string" "c4_l0_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c4_l0_0"
  }
}
resource "random_string" "c4_l1_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c4_l1_0"
    p0    = random_string.c4_l0_0.result
  }
}
resource "null_resource" "c4_l1_1" {
  triggers = {
    label = "${local.name_prefix}-c4_l1_1"
    p0    = random_string.c4_l0_0.result
  }
}
resource "random_string" "c4_l2_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c4_l2_0"
    p0    = random_string.c4_l0_0.result
    p1    = null_resource.c4_l1_1.id
  }
}
resource "random_string" "c4_l2_1" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c4_l2_1"
    p0    = random_string.c4_l1_0.result
    p1    = null_resource.c4_l1_1.id
  }
}
resource "random_string" "c4_l2_2" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c4_l2_2"
    p0    = null_resource.c4_l1_1.id
  }
}
resource "random_integer" "c4_l2_3" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c4_l2_3"
    p0    = null_resource.c4_l1_1.id
    p1    = random_string.c4_l0_0.result
    p2    = random_string.c4_l1_0.result
  }
}

# === pocket c5: independent random/null backbone ===
resource "random_id" "c5_l0_0" {
  byte_length = 8
  keepers = {
    label = "${local.name_prefix}-c5_l0_0"
  }
}
resource "random_integer" "c5_l0_1" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c5_l0_1"
  }
}
resource "random_integer" "c5_l1_0" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c5_l1_0"
    p0    = random_id.c5_l0_0.hex
    p1    = random_integer.c5_l0_1.id
  }
}
resource "null_resource" "c5_l1_1" {
  triggers = {
    label = "${local.name_prefix}-c5_l1_1"
    p0    = random_id.c5_l0_0.hex
    p1    = random_integer.c5_l0_1.id
  }
}
resource "random_pet" "c5_l1_2" {
  length    = 2
  separator = "-"
  keepers = {
    label = "${local.name_prefix}-c5_l1_2"
    p0    = random_integer.c5_l0_1.id
    p1    = random_id.c5_l0_0.hex
  }
}
resource "null_resource" "c5_l1_3" {
  triggers = {
    label = "${local.name_prefix}-c5_l1_3"
    p0    = random_integer.c5_l0_1.id
    p1    = random_id.c5_l0_0.hex
  }
}
resource "null_resource" "c5_l1_4" {
  triggers = {
    label = "${local.name_prefix}-c5_l1_4"
    p0    = random_integer.c5_l0_1.id
    p1    = random_id.c5_l0_0.hex
  }
}
resource "null_resource" "c5_l2_0" {
  triggers = {
    label = "${local.name_prefix}-c5_l2_0"
    p0    = null_resource.c5_l1_4.id
    p1    = random_pet.c5_l1_2.id
  }
}
resource "random_integer" "c5_l2_1" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c5_l2_1"
    p0    = null_resource.c5_l1_3.id
    p1    = null_resource.c5_l1_4.id
    p2    = random_id.c5_l0_0.hex
  }
}
resource "random_integer" "c5_l2_2" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c5_l2_2"
    p0    = null_resource.c5_l1_3.id
    p1    = null_resource.c5_l1_1.id
  }
}

# === pocket c6: lonely single-node pocket ===
resource "null_resource" "c6_l0_0" {
  triggers = {
    label = "${local.name_prefix}-c6_l0_0"
  }
}

