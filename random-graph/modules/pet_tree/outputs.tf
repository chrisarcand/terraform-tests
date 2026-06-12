locals {
  # All layer instance IDs gathered into one list-of-lists, indexed by layer.
  layer_ids = [
    random_pet.layer_0[*].id,
    random_pet.layer_1[*].id,
    random_pet.layer_2[*].id,
    random_pet.layer_3[*].id,
    random_pet.layer_4[*].id,
    random_pet.layer_5[*].id,
    random_pet.layer_6[*].id,
    random_pet.layer_7[*].id,
    random_pet.layer_8[*].id,
    random_pet.layer_9[*].id,
  ]

  deepest_layer = var.layers - 1
}

output "pet_count" {
  description = "Total number of random_pet resources in the tree."
  value       = sum(local.widths)
}

output "layer_widths" {
  description = "Number of pets in each layer (0 for inactive layers)."
  value       = local.widths
}

output "branching" {
  value = var.branching
}

output "layers" {
  value = var.layers
}

output "root" {
  description = "ID of the root pet (layer 0, index 0)."
  value       = try(random_pet.layer_0[0].id, "")
}

output "deepest_layer_count" {
  description = "Number of leaf pets in the deepest active layer."
  value       = local.widths[local.deepest_layer]
}

output "leaves_sample" {
  description = "A small sample of pet names from the deepest active layer."
  value       = slice(local.layer_ids[local.deepest_layer], 0, min(5, length(local.layer_ids[local.deepest_layer])))
}
