locals {
  # Width of each of the 10 possible layers. Layer i has branching^i nodes,
  # optionally capped by max_layer_width, and 0 once we pass `layers`.
  widths = [
    for i in range(10) :
    i < var.layers ? (
      var.max_layer_width > 0
      ? min(floor(pow(var.branching, i)), var.max_layer_width)
      : floor(pow(var.branching, i))
    ) : 0
  ]
}

# ---------------------------------------------------------------------------
# Layer 0 — the root(s). No parent; seeded from the upstream value so that the
# whole tree re-derives if the producing workspace's output changes.
# ---------------------------------------------------------------------------
resource "random_pet" "layer_0" {
  count     = local.widths[0]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l0"

  keepers = {
    layer = "0"
    root  = var.root_seed
  }
}

# ---------------------------------------------------------------------------
# Layers 1-9 — each node references its parent in the previous layer via
# keepers, producing a real dependency edge. Each leaf therefore
# carries the full transitive closure of its ancestry in `dependencies`.
# ---------------------------------------------------------------------------
resource "random_pet" "layer_1" {
  count     = local.widths[1]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l1"

  keepers = {
    layer  = "1"
    parent = random_pet.layer_0[floor(count.index / var.branching)].id
  }
}

resource "random_pet" "layer_2" {
  count     = local.widths[2]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l2"

  keepers = {
    layer  = "2"
    parent = random_pet.layer_1[floor(count.index / var.branching)].id
  }
}

resource "random_pet" "layer_3" {
  count     = local.widths[3]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l3"

  keepers = {
    layer  = "3"
    parent = random_pet.layer_2[floor(count.index / var.branching)].id
  }
}

resource "random_pet" "layer_4" {
  count     = local.widths[4]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l4"

  keepers = {
    layer  = "4"
    parent = random_pet.layer_3[floor(count.index / var.branching)].id
  }
}

resource "random_pet" "layer_5" {
  count     = local.widths[5]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l5"

  keepers = {
    layer  = "5"
    parent = random_pet.layer_4[floor(count.index / var.branching)].id
  }
}

resource "random_pet" "layer_6" {
  count     = local.widths[6]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l6"

  keepers = {
    layer  = "6"
    parent = random_pet.layer_5[floor(count.index / var.branching)].id
  }
}

resource "random_pet" "layer_7" {
  count     = local.widths[7]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l7"

  keepers = {
    layer  = "7"
    parent = random_pet.layer_6[floor(count.index / var.branching)].id
  }
}

resource "random_pet" "layer_8" {
  count     = local.widths[8]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l8"

  keepers = {
    layer  = "8"
    parent = random_pet.layer_7[floor(count.index / var.branching)].id
  }
}

resource "random_pet" "layer_9" {
  count     = local.widths[9]
  length    = var.pet_length
  separator = var.separator
  prefix    = "${var.name_prefix}-l9"

  keepers = {
    layer  = "9"
    parent = random_pet.layer_8[floor(count.index / var.branching)].id
  }
}
