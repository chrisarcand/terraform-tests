# ---------------------------------------------------------------------------
# leafy-graphs :: roots
#
# An organic dependency graph made of SEVERAL INDEPENDENT pockets (no single
# root). Edges are implicit references within a pocket; pockets are not
# connected to each other -- mirroring how real configs form provider/
# resource clusters with multiple roots and leaves at varied depths.
#
# pockets: primary(8), time(6), random_null(8)
# cross-workspace upstreams: none (this is a root workspace)
# providers (all in-memory): null, random, time
# ---------------------------------------------------------------------------

provider "null" {}
provider "random" {}
provider "time" {}

locals {
  name_prefix = "${var.workspace_prefix}-roots"
  upstream    = {}
}

# === pocket c0: primary random/null backbone -- the cross-workspace remote_state sink ===
resource "random_id" "c0_l0_0" {
  byte_length = 8
  keepers = {
    label = "${local.name_prefix}-c0_l0_0"
  }
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
resource "null_resource" "c0_l1_0" {
  triggers = {
    label = "${local.name_prefix}-c0_l1_0"
    p0    = random_id.c0_l0_0.hex
    p1    = random_pet.c0_l0_1.id
  }
}
resource "random_string" "c0_l2_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l2_0"
    p0    = null_resource.c0_l1_0.id
    p1    = random_id.c0_l0_0.hex
  }
}
resource "null_resource" "c0_l2_1" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_1"
    p0    = random_string.c0_l0_2.result
    p1    = null_resource.c0_l1_0.id
    p2    = random_id.c0_l0_0.hex
  }
}
resource "random_string" "c0_l2_2" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c0_l2_2"
    p0    = random_string.c0_l0_2.result
  }
}
resource "null_resource" "c0_l2_3" {
  triggers = {
    label = "${local.name_prefix}-c0_l2_3"
    p0    = random_string.c0_l0_2.result
    p1    = null_resource.c0_l1_0.id
  }
}

# === pocket c1: time pocket ===
resource "time_static" "c1_l0_0" {
}
resource "time_offset" "c1_l0_1" {
  offset_days = 30
}
resource "null_resource" "c1_l1_0" {
  triggers = {
    label = "${local.name_prefix}-c1_l1_0"
    p0    = time_static.c1_l0_0.id
    p1    = time_offset.c1_l0_1.id
  }
}
resource "null_resource" "c1_l1_1" {
  triggers = {
    label = "${local.name_prefix}-c1_l1_1"
    p0    = time_offset.c1_l0_1.id
    p1    = time_static.c1_l0_0.id
  }
}
resource "random_string" "c1_l2_0" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c1_l2_0"
    p0    = null_resource.c1_l1_1.id
    p1    = null_resource.c1_l1_0.id
  }
}
resource "time_static" "c1_l2_1" {
  triggers = {
    p0 = null_resource.c1_l1_1.id
    p1 = time_static.c1_l0_0.id
    p2 = time_offset.c1_l0_1.id
  }
}

# === pocket c2: independent random/null backbone ===
resource "random_id" "c2_l0_0" {
  byte_length = 8
  keepers = {
    label = "${local.name_prefix}-c2_l0_0"
  }
}
resource "random_integer" "c2_l0_1" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c2_l0_1"
  }
}
resource "random_integer" "c2_l1_0" {
  min = 1
  max = 999999
  keepers = {
    label = "${local.name_prefix}-c2_l1_0"
    p0    = random_id.c2_l0_0.hex
  }
}
resource "random_pet" "c2_l1_1" {
  length    = 2
  separator = "-"
  keepers = {
    label = "${local.name_prefix}-c2_l1_1"
    p0    = random_id.c2_l0_0.hex
  }
}
resource "null_resource" "c2_l1_2" {
  triggers = {
    label = "${local.name_prefix}-c2_l1_2"
    p0    = random_id.c2_l0_0.hex
  }
}
resource "random_string" "c2_l1_3" {
  length  = 12
  special = false
  keepers = {
    label = "${local.name_prefix}-c2_l1_3"
    p0    = random_id.c2_l0_0.hex
    p1    = random_integer.c2_l0_1.id
  }
}
resource "null_resource" "c2_l1_4" {
  triggers = {
    label = "${local.name_prefix}-c2_l1_4"
    p0    = random_integer.c2_l0_1.id
    p1    = random_id.c2_l0_0.hex
  }
}
resource "null_resource" "c2_l2_0" {
  triggers = {
    label = "${local.name_prefix}-c2_l2_0"
    p0    = random_integer.c2_l1_0.id
  }
}

