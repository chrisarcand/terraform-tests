output "primary_seed" {
  description = "Non-sensitive seed (random_id hex) consumed by downstream workspaces."
  value       = random_id.c0_l0_0.hex
}

output "pet_name" {
  description = "Non-sensitive pet name consumed by downstream workspaces."
  value       = random_pet.c0_l0_1.id
}

output "node_count" {
  value = 28
}

output "edge_count" {
  value = 33
}

output "pocket_count" {
  description = "Number of independent (disconnected) pockets in this workspace."
  value       = 5
}

output "tip_id" {
  description = "Id of a deep leaf node, just to show value flow."
  value       = null_resource.c3_l2_3.id
}

output "cert_fingerprint" {
  value = tls_self_signed_cert.c1_l1_0.id
}

output "sensitive_secret" {
  description = "Sensitive output -- redacted as <sensitive> in state and UI."
  value       = random_password.c2_l0_0.result
  sensitive   = true
}
