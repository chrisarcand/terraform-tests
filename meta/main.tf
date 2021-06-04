provider "tfe" {
  token = var.provider_token
}

resource "tfe_workspace" "workspaces" {
  for_each = var.workspaces

  name         = each.key
  organization = var.organization_name

  auto_apply        = each.value["auto_apply"]
  terraform_version = each.value["terraform_version"]
  execution_mode    = each.value["execution_mode"]
  working_directory = each.value["working_directory"] 
  dynamic "vcs_repo" {
    for_each = each.value.vcs_repo.*
    content {
      identifier     = vcs_repo.value["identifier"]
      oauth_token_id = var.oauth_token_id
      branch         = vcs_repo.value["branch"]
    }
  }
}

# As an example: This resource will create a variable sourced from the meta
# workspace created for each workspace in the workspaces map of objects- in this case,
# a token to use the TFE provider instantly in any workspace.
resource "tfe_variable" "provider_token" {
  for_each = var.workspaces

  workspace_id = tfe_workspace.workspaces[each.key].id
  key          = "provider_token"
  value        = var.provider_token
  category     = "terraform"
  sensitive    = true
  description = "TFE provider token, sourced from 'meta' workspace"
}
