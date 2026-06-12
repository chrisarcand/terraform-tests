output "primary_seed" {
  description = "Non-sensitive seed (leaf workspace; nothing consumes it)."
  value       = module.graph.primary_seed
}

output "resource_total" {
  value = module.graph.resource_total
}

output "cert_pem" {
  description = "Non-sensitive self-signed cert PEM from the graph module."
  value       = module.graph.cert_pem
}

output "from_platform_seed" {
  description = "Echo of platform's seed, proving the platform -> app read."
  value       = data.terraform_remote_state.platform.outputs.primary_seed
}

output "sensitive_secret" {
  value     = module.graph.sensitive_secret
  sensitive = true
}
