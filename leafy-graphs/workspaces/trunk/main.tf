# ---------------------------------------------------------------------------
# leafy-graphs :: trunk
#
# An organic dependency graph made of SEVERAL INDEPENDENT pockets (no single
# root). Edges are implicit references within a pocket; pockets are not
# connected to each other -- mirroring how real configs form provider/
# resource clusters with multiple roots and leaves at varied depths.
#
# pockets: primary(14), tls(2), password(1), random_null(11), random_null(5), lone(1)
# cross-workspace upstreams (remote_state): roots
# providers (all in-memory): null, random, tls
# ---------------------------------------------------------------------------

provider "null" {}
provider "random" {}
provider "tls" {}

data "terraform_remote_state" "roots" {
  backend = "remote"
  config = {
    hostname     = var.tfe_hostname
    organization = var.tfe_organization
    workspaces = {
      name = "${var.workspace_prefix}-roots"
    }
  }
}

locals {
  name_prefix = "${var.workspace_prefix}-trunk"
  upstream = {
    roots_seed = data.terraform_remote_state.roots.outputs.primary_seed
    roots_pet  = data.terraform_remote_state.roots.outputs.pet_name
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
    p0    = random_integer.c0_l0_3.id
    p1    = random_id.c0_l0_0.hex
    p2    = random_pet.c0_l0_1.id
  }
}
resource "null_resource" "c0_l1_1" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_1"
    p0    = random_pet.c0_l0_1.id
    p1    = random_string.c0_l0_2.result
  }
}
resource "null_resource" "c0_l1_2" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_2"
    p0    = random_pet.c0_l0_1.id
    p1    = random_id.c0_l0_0.hex
  }
}
resource "null_resource" "c0_l1_3" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_3"
    p0    = random_integer.c0_l0_3.id
    p1    = random_pet.c0_l0_1.id
    p2    = random_id.c0_l0_0.hex
  }
}
resource "null_resource" "c0_l2_0" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_0"
    p0    = null_resource.c0_l1_3.id
    p1    = null_resource.c0_l1_2.id
  }
}
resource "random_integer" "c0_l2_1" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c0_l2_1"
    p0    = random_integer.c0_l0_3.id
    p1    = null_resource.c0_l1_3.id
  }
}
resource "null_resource" "c0_l2_2" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_2"
    p0    = null_resource.c0_l1_2.id
    p1    = null_resource.c0_l1_1.id
    p2    = random_pet.c0_l0_1.id
  }
}
resource "random_string" "c0_l2_3" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l2_3"
    p0    = null_resource.c0_l1_3.id
  }
}
resource "null_resource" "c0_l2_4" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_4"
    p0    = null_resource.c0_l1_0.id
    p1    = random_pet.c0_l0_1.id
  }
}
resource "random_string" "c0_l3_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l3_0"
    p0    = null_resource.c0_l2_0.id
    p1    = null_resource.c0_l1_0.id
    p2    = random_id.c0_l0_0.hex
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
resource "random_string" "c3_l1_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c3_l1_0"
    p0    = random_string.c3_l0_0.result
  }
}
resource "random_string" "c3_l1_1" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c3_l1_1"
    p0    = random_pet.c3_l0_1.id
    p1    = random_string.c3_l0_0.result
  }
}
resource "random_string" "c3_l1_2" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c3_l1_2"
    p0    = random_pet.c3_l0_1.id
  }
}
resource "random_string" "c3_l1_3" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c3_l1_3"
    p0    = random_string.c3_l0_0.result
  }
}
resource "random_integer" "c3_l1_4" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c3_l1_4"
    p0    = random_string.c3_l0_0.result
  }
}
resource "null_resource" "c3_l1_5" {
  triggers = {
    label = "${local.name_prefix}-c3_l1_5"
    p0    = random_pet.c3_l0_1.id
    p1    = random_string.c3_l0_0.result
  }
}
resource "null_resource" "c3_l2_0" {
  triggers = {
    label = "${local.name_prefix}-c3_l2_0"
    p0    = random_string.c3_l1_0.result
    p1    = random_integer.c3_l1_4.id
  }
}
resource "null_resource" "c3_l2_1" {
  triggers = {
    label = "${local.name_prefix}-c3_l2_1"
    p0    = random_string.c3_l1_1.result
    p1    = random_string.c3_l1_3.result
  }
}
resource "null_resource" "c3_l2_2" {
  triggers = {
    label = "${local.name_prefix}-c3_l2_2"
    p0    = null_resource.c3_l1_5.id
    p1    = random_string.c3_l1_3.result
  }
}

# === pocket c4: independent random/null backbone ===
resource "random_id" "c4_l0_0" {
  byte_length = 8
  keepers = {
    label = "${local.name_prefix}-c4_l0_0"
  }
}
resource "random_pet" "c4_l1_0" {
  length    = 2
  separator = "-"
  keepers = {
    label = "${local.name_prefix}-c4_l1_0"
    p0    = random_id.c4_l0_0.hex
  }
}
resource "null_resource" "c4_l1_1" {
  triggers = {
    label = "${local.name_prefix}-c4_l1_1"
    p0    = random_id.c4_l0_0.hex
  }
}
resource "null_resource" "c4_l1_2" {
  triggers = {
    label = "${local.name_prefix}-c4_l1_2"
    p0    = random_id.c4_l0_0.hex
  }
}
resource "null_resource" "c4_l2_0" {
  triggers = {
    label = "${local.name_prefix}-c4_l2_0"
    p0    = null_resource.c4_l1_2.id
  }
}

# === pocket c5: lonely single-node pocket ===
resource "null_resource" "c5_l0_0" {
  triggers = {
    label = "${local.name_prefix}-c5_l0_0"
  }
}

