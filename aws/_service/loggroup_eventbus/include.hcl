locals {
  env_project_name   = get_env("TF_VAR_env_project_name")
  env_workspace_name = get_env("TF_VAR_env_workspace_name", "default")
  naming_prefix      = "${local.env_project_name}-${local.env_workspace_name}-terragrunt"
  account_vars       = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
}

inputs = {
  log_group_name = "/aws/events/${local.naming_prefix}-${local.account_vars.account_name}-include"
  event_bus_name = "${local.naming_prefix}-${local.account_vars.account_name}-include"
}
