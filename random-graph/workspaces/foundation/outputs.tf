output "primary_seed" {
  description = "Non-sensitive seed consumed by network, data, and pets."
  value       = module.graph.primary_seed
}

output "pet_name" {
  description = "Non-sensitive pet name consumed downstream."
  value       = module.graph.pet_name
}

output "region_code" {
  description = "A constant output, handy for cross-workspace value flow demos."
  value       = "us-east-1"
}

output "resource_total" {
  value = module.graph.resource_total
}

output "sensitive_secret" {
  description = "Sensitive output — redacted as <sensitive> in state and UI."
  value       = module.graph.sensitive_secret
  sensitive   = true
}
