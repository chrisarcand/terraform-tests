output "name_prefix" {
  description = "The prefix used for this workspace's resources."
  value       = var.name_prefix
}

output "primary_seed" {
  description = "A non-sensitive seed value (random_id hex) intended to be consumed by downstream workspaces."
  value       = try(random_id.seed[0].hex, "")
}

output "pet_name" {
  description = "A non-sensitive pet name intended to be consumed by downstream workspaces."
  value       = try(random_pet.l1[0].id, "")
}

output "shuffled" {
  description = "Result of the first shuffle (non-sensitive)."
  value       = try(random_shuffle.l3[0].result, [])
}

output "uuid_sample" {
  description = "A sample uuid (non-sensitive)."
  value       = try(random_uuid.l2[0].result, "")
}

output "cert_pem" {
  description = "PEM of the first self-signed certificate (non-sensitive public cert)."
  value       = try(tls_self_signed_cert.cert[0].cert_pem, "")
}

output "sensitive_secret" {
  description = "A sensitive value (random_password). Redacted as <sensitive> in outputs."
  value       = try(random_password.l2[0].result, "")
  sensitive   = true
}

output "resource_total" {
  description = "Count of managed resources created by this module instance."
  value       = local.resource_total
}
