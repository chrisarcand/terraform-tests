# ---------------------------------------------------------------------------
# leafy-graphs :: leaves
#
# An organic dependency graph made of SEVERAL INDEPENDENT pockets (no single
# root). Edges are implicit references within a pocket; pockets are not
# connected to each other -- mirroring how real configs form provider/
# resource clusters with multiple roots and leaves at varied depths.
#
# pockets: primary(15), tls(4), password(1), random_null(7), lone(1)
# cross-workspace upstreams (remote_state): branch, canopy
# providers (all in-memory): null, random, tls
# ---------------------------------------------------------------------------

provider "null" {}
provider "random" {}
provider "tls" {}

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

data "terraform_remote_state" "canopy" {
  backend = "remote"
  config = {
    hostname     = var.tfe_hostname
    organization = var.tfe_organization
    workspaces = {
      name = "${var.workspace_prefix}-canopy"
    }
  }
}

locals {
  name_prefix = "${var.workspace_prefix}-leaves"
  upstream = {
    branch_seed = data.terraform_remote_state.branch.outputs.primary_seed
    branch_pet  = data.terraform_remote_state.branch.outputs.pet_name
    canopy_seed = data.terraform_remote_state.canopy.outputs.primary_seed
    canopy_pet  = data.terraform_remote_state.canopy.outputs.pet_name
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
resource "random_integer" "c0_l1_0" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l1_0"
    p0    = random_pet.c0_l0_1.id
  }
}
resource "null_resource" "c0_l1_1" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_1"
    p0    = random_pet.c0_l0_1.id
    p1    = random_string.c0_l0_2.result
  }
}
resource "null_resource" "c0_l2_0" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_0"
    p0    = random_id.c0_l0_0.hex
    p1    = random_integer.c0_l1_0.id
  }
}
resource "null_resource" "c0_l2_1" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_1"
    p0    = null_resource.c0_l1_1.id
    p1    = random_integer.c0_l0_3.id
  }
}
resource "null_resource" "c0_l2_2" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_2"
    p0    = random_string.c0_l0_2.result
    p1    = null_resource.c0_l1_1.id
    p2    = random_id.c0_l0_0.hex
  }
}
resource "random_string" "c0_l2_3" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l2_3"
    p0    = random_integer.c0_l1_0.id
  }
}
resource "null_resource" "c0_l3_0" {
  triggers = {
    label = "${local.name_prefix}-c0_l3_0"
    p0    = null_resource.c0_l2_1.id
    p1    = null_resource.c0_l2_2.id
  }
}
resource "random_string" "c0_l3_1" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l3_1"
    p0    = null_resource.c0_l2_1.id
  }
}
resource "null_resource" "c0_l3_2" {
  triggers = {
    label = "${local.name_prefix}-c0_l3_2"
    p0    = random_string.c0_l2_3.result
    p1    = random_integer.c0_l1_0.id
  }
}
resource "random_integer" "c0_l3_3" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l3_3"
    p0    = random_pet.c0_l0_1.id
    p1    = null_resource.c0_l2_2.id
    p2    = null_resource.c0_l2_0.id
  }
}
resource "null_resource" "c0_l3_4" {
  triggers = {
    label = "${local.name_prefix}-c0_l3_4"
    p0    = null_resource.c0_l2_0.id
    p1    = random_string.c0_l0_2.result
  }
}

# === pocket c1: tls pocket: private key -> self-signed cert ===
resource "tls_private_key" "c1_l0_0" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "tls_self_signed_cert" "c1_l1_0" {
  private_key_pem       = tls_private_key.c1_l0_0.private_key_pem
  validity_period_hours = 8760
  allowed_uses          = ["key_encipherment", "digital_signature", "server_auth"]
  subject {
    common_name  = "${local.name_prefix}-c1_l1_0.example.com"
    organization = "Leafy Graphs Demo"
  }
}
resource "null_resource" "c1_l2_0" {
  triggers = {
    label = "${local.name_prefix}-c1_l2_0"
    p0    = tls_self_signed_cert.c1_l1_0.id
  }
}
resource "null_resource" "c1_l2_1" {
  triggers = {
    label = "${local.name_prefix}-c1_l2_1"
    p0    = tls_self_signed_cert.c1_l1_0.id
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
resource "random_string" "c3_l1_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c3_l1_0"
    p0    = random_string.c3_l0_0.result
  }
}
resource "random_integer" "c3_l1_1" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c3_l1_1"
    p0    = random_string.c3_l0_0.result
  }
}
resource "random_string" "c3_l2_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c3_l2_0"
    p0    = random_integer.c3_l1_1.id
  }
}
resource "random_integer" "c3_l2_1" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c3_l2_1"
    p0    = random_integer.c3_l1_1.id
    p1    = random_string.c3_l1_0.result
  }
}
resource "null_resource" "c3_l2_2" {
  triggers = {
    label = "${local.name_prefix}-c3_l2_2"
    p0    = random_string.c3_l1_0.result
    p1    = random_integer.c3_l1_1.id
  }
}
resource "null_resource" "c3_l2_3" {
  triggers = {
    label = "${local.name_prefix}-c3_l2_3"
    p0    = random_integer.c3_l1_1.id
    p1    = random_string.c3_l1_0.result
  }
}

# === pocket c4: lonely single-node pocket ===
resource "random_string" "c4_l0_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c4_l0_0"
  }
}

