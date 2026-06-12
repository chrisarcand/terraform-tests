output "primary_seed" {
  description = "Non-sensitive seed (random_id hex) consumed by downstream workspaces."
  value       = random_id.c0_l0_0.hex
}

output "pet_name" {
  description = "Non-sensitive pet name consumed by downstream workspaces."
  value       = random_pet.c0_l0_1.id
}

output "node_count" {
  value = 70
}

output "edge_count" {
  value = 113
}

output "pocket_count" {
  description = "Number of independent (disconnected) pockets in this workspace."
  value       = 7
}

output "tip_id" {
  description = "Id of a deep leaf node, just to show value flow."
  value       = null_resource.c5_l2_0.id
}

output "sensitive_secret" {
  description = "Sensitive output -- redacted as <sensitive> in state and UI."
  value       = random_password.c2_l0_0.result
  sensitive   = true
}
