output "primary_seed" {
  description = "Non-sensitive seed consumed by app."
  value       = module.graph.primary_seed
}

output "pet_name" {
  value = module.graph.pet_name
}

output "resource_total" {
  value = module.graph.resource_total
}

output "from_network_seed" {
  description = "Echo of network's seed, proving the network -> platform read."
  value       = data.terraform_remote_state.network.outputs.primary_seed
}

output "from_data_seed" {
  description = "Echo of data's seed, proving the data -> platform read."
  value       = data.terraform_remote_state.data.outputs.primary_seed
}

output "sensitive_secret" {
  value     = module.graph.sensitive_secret
  sensitive = true
}
