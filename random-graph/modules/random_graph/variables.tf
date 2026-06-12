variable "name_prefix" {
  type        = string
  description = "Prefix applied to resource names/labels in this workspace's graph."
}

variable "upstream" {
  type        = map(string)
  description = <<-EOT
    Non-sensitive values read from upstream workspaces via terraform_remote_state.
    These are woven into the keepers of the seed layer so that cross-workspace
    data genuinely flows into this workspace's resources (and the read creates a
    dependency edge from this workspace to its upstream).
  EOT
  default     = {}
}

variable "enable_tls" {
  type        = bool
  description = "Create tls_private_key / tls_self_signed_cert resources (adds sensitive attributes and a second provider)."
  default     = true
}

variable "enable_null" {
  type        = bool
  description = "Create null_resource glue resources that demonstrate explicit depends_on alongside implicit trigger references."
  default     = true
}

# ---------------------------------------------------------------------------
# Per-layer resource counts. Defaults sum to ~100 managed resources.
# ---------------------------------------------------------------------------
variable "id_seed_count" {
  type    = number
  default = 6
}

variable "int_seed_count" {
  type    = number
  default = 6
}

variable "string_count" {
  type    = number
  default = 16
}

variable "pet_count" {
  type    = number
  default = 12
}

variable "password_count" {
  type    = number
  default = 12
}

variable "uuid_count" {
  type    = number
  default = 12
}

variable "shuffle_count" {
  type    = number
  default = 8
}

variable "bytes_count" {
  type    = number
  default = 8
}

variable "tls_key_count" {
  type    = number
  default = 6
}

variable "null_count" {
  type    = number
  default = 8
}

# ---------------------------------------------------------------------------
# Resource shape knobs.
# ---------------------------------------------------------------------------
variable "string_length" {
  type    = number
  default = 16
}

variable "password_length" {
  type    = number
  default = 24
}

variable "pet_length" {
  type    = number
  default = 2
}

variable "int_min" {
  type    = number
  default = 1
}

variable "int_max" {
  type    = number
  default = 100000
}
