output "primary_seed" {
  description = "Non-sensitive seed consumed by platform."
  value       = module.graph.primary_seed
}

output "pet_name" {
  value = module.graph.pet_name
}

output "resource_total" {
  value = module.graph.resource_total
}

output "from_foundation_seed" {
  description = "Echo of the upstream value, proving the cross-workspace read."
  value       = data.terraform_remote_state.foundation.outputs.primary_seed
}

output "sensitive_secret" {
  value     = module.graph.sensitive_secret
  sensitive = true
}
