locals {
  # Guard divisors so a user who zeroes out a seed layer doesn't hit divide-by-zero
  # in the modulo wiring below (the index itself still requires count >= 1).
  id_mod  = max(var.id_seed_count, 1)
  int_mod = max(var.int_seed_count, 1)
  str_mod = max(var.string_count, 1)
  pet_mod = max(var.pet_count, 1)
  uid_mod = max(var.uuid_count, 1)

  # Fan-in input for the shuffle layer: a slice of layer-1 strings + layer-2 uuids.
  shuffle_input = concat(
    slice(random_string.l1[*].result, 0, min(4, var.string_count)),
    slice(random_uuid.l2[*].result, 0, min(4, var.uuid_count)),
  )

  resource_total = (
    var.id_seed_count + var.int_seed_count + var.string_count + var.pet_count +
    var.password_count + var.uuid_count + var.shuffle_count + var.bytes_count +
    (var.enable_tls ? var.tls_key_count * 2 : 0) +
    (var.enable_null ? var.null_count : 0)
  )
}

# ===========================================================================
# Layer 0 — seeds. No intra-workspace dependencies. The upstream map (from
# terraform_remote_state) is merged into keepers so cross-workspace data flows
# in and the remote-state read is recorded in this workspace's state.
# ===========================================================================
resource "random_id" "seed" {
  count       = var.id_seed_count
  byte_length = 8

  keepers = merge({
    prefix = var.name_prefix
    idx    = tostring(count.index)
  }, var.upstream)
}

resource "random_integer" "seed" {
  count = var.int_seed_count
  min   = var.int_min
  max   = var.int_max

  keepers = merge({
    prefix = var.name_prefix
    idx    = tostring(count.index)
  }, var.upstream)
}

# ===========================================================================
# Layer 1 — strings and pets keyed off the seeds (implicit references via
# keepers). random_pet also folds in the upstream map.
# ===========================================================================
resource "random_string" "l1" {
  count   = var.string_count
  length  = var.string_length
  special = false

  keepers = {
    seed   = random_id.seed[count.index % local.id_mod].hex
    prefix = var.name_prefix
  }
}

resource "random_pet" "l1" {
  count  = var.pet_count
  length = var.pet_length

  keepers = merge({
    seed = tostring(random_integer.seed[count.index % local.int_mod].result)
  }, var.upstream)
}

# ===========================================================================
# Layer 2 — passwords (SENSITIVE) and uuids. Passwords are a sink: nothing
# downstream references their value, so sensitivity does not propagate.
# ===========================================================================
resource "random_password" "l2" {
  count   = var.password_count
  length  = var.password_length
  special = true

  keepers = {
    upstream_string = random_string.l1[count.index % local.str_mod].result
    label           = "${var.name_prefix}-pw-${count.index}"
  }
}

resource "random_uuid" "l2" {
  count = var.uuid_count

  keepers = {
    pet = random_pet.l1[count.index % local.pet_mod].id
  }
}

# ===========================================================================
# Layer 3 — fan-in. shuffle consumes a mix of layer-1/2 results; bytes keys
# off the uuids.
# ===========================================================================
resource "random_shuffle" "l3" {
  count = var.shuffle_count
  input = local.shuffle_input
}

resource "random_bytes" "l3" {
  count  = var.bytes_count
  length = 16

  keepers = {
    uuid = random_uuid.l2[count.index % local.uid_mod].result
  }
}

# ===========================================================================
# TLS layer — a private key (SENSITIVE) and a self-signed cert that depends on
# it. Adds a distinct provider and rich sensitive attributes to the graph.
# ===========================================================================
resource "tls_private_key" "key" {
  count     = var.enable_tls ? var.tls_key_count : 0
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "cert" {
  count           = var.enable_tls ? var.tls_key_count : 0
  private_key_pem = tls_private_key.key[count.index].private_key_pem

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  subject {
    common_name  = "${var.name_prefix}-${count.index}.example.com"
    organization = "Random Graph Demo"
  }
}

# ===========================================================================
# Glue layer — null_resource demonstrating BOTH kinds of dependency:
# implicit (trigger references) and explicit (depends_on).
# ===========================================================================
resource "null_resource" "glue" {
  count = var.enable_null ? var.null_count : 0

  triggers = {
    string = random_string.l1[count.index % local.str_mod].result
    uuid   = random_uuid.l2[count.index % local.uid_mod].result
    pet    = random_pet.l1[count.index % local.pet_mod].id
  }

  depends_on = [
    random_shuffle.l3,
    random_bytes.l3,
  ]
}
