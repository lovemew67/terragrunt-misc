locals {
  env_project_name   = get_env("TF_VAR_env_project_name")
  env_workspace_name = get_env("TF_VAR_env_workspace_name", "default")
  naming_prefix      = "${local.env_project_name}-${local.env_workspace_name}-terragrunt"
  account_vars       = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
}

dependency "loggroup_eventbus" {
  config_path = "${dirname(find_in_parent_folders("account.hcl"))}/loggroup_eventbus/include"
}

inputs = {
  event_bus_name    = dependency.loggroup_eventbus.outputs.event_bus_name
  event_rule_name   = "${local.naming_prefix}-${local.account_vars.account_name}-include"
  event_pattern     = <<PATTERN
{
	"detail-type" : [
      "ASDF"
    ]
}
PATTERN
  event_target_name = "${local.naming_prefix}-${local.account_vars.account_name}-include"
  target_arn        = dependency.loggroup_eventbus.outputs.log_group_arn
}
