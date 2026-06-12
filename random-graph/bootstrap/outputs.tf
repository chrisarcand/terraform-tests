output "workspace_ids" {
  description = "Map of role -> workspace ID."
  value       = { for role, ws in tfe_workspace.ws : role => ws.id }
}

output "workspace_names" {
  description = "Map of role -> workspace name."
  value       = { for role, ws in tfe_workspace.ws : role => ws.name }
}

output "workspace_urls" {
  description = "Map of role -> HCP Terraform workspace URL."
  value = {
    for role, ws in tfe_workspace.ws :
    role => "https://${var.tfe_hostname}/app/${var.tfe_organization}/workspaces/${ws.name}"
  }
}

output "dependency_edges" {
  description = "Cross-workspace producer -> consumer edges (apply in this order)."
  value       = local.edges
}

output "run_trigger_ids" {
  description = "Map of 'producer->consumer' edge to its tfe_run_trigger ID."
  value       = { for k, rt in tfe_run_trigger.edges : k => rt.id }
}

output "project_id" {
  description = "Project the workspaces were placed in (null = org default)."
  value       = local.project_id
}
