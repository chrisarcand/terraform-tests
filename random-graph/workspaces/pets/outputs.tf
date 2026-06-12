output "pet_count" {
  description = "Total random_pet resources in the tree (1023 for a full 10-layer binary tree)."
  value       = module.tree.pet_count
}

output "layer_widths" {
  description = "Pets per layer: [1, 2, 4, 8, ..., 512]."
  value       = module.tree.layer_widths
}

output "root" {
  description = "The root pet name (layer 0)."
  value       = module.tree.root
}

output "deepest_layer_count" {
  description = "Number of leaf pets in the deepest layer (512)."
  value       = module.tree.deepest_layer_count
}

output "leaves_sample" {
  description = "A small sample of leaf pet names."
  value       = module.tree.leaves_sample
}

output "from_foundation_seed" {
  description = "Echo of foundation's seed, proving the foundation -> pets read."
  value       = data.terraform_remote_state.foundation.outputs.primary_seed
}
