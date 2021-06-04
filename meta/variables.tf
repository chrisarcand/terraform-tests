variable "organization_name" {
  type = string
}

variable "provider_token" {
  type = string
}

variable "oauth_token_id" {
  type = string
}

variable "workspaces" {
  type = map(object({
    auto_apply = optional(bool)
    terraform_version = optional(string)
    execution_mode    = optional(string)
    allow_destroy_plan = optional(bool)
    working_directory = optional(string)
    file_triggers_enabled = optional(bool)
    trigger_prefixes = optional(list(string))
    vcs_repo          = optional(object({
      identifier = string
      oauth_token_id = optional(string)
      branch = optional(string)
      submodule_ingress = optional(bool)
    }))
  }))

  description = "This map of objects allows for simplified creation of a workspace with any resources that are always desired to be included with it."
}

