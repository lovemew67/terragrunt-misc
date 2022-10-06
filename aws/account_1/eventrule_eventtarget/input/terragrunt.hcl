include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
}

dependency "loggroup_eventbus" {
  config_path = "${dirname(find_in_parent_folders("account.hcl"))}/loggroup_eventbus/input"
}

terraform {
  source = "${dirname(find_in_parent_folders())}/_service/eventrule_eventtarget"
}

inputs = {
  event_bus_name    = dependency.loggroup_eventbus.outputs.event_bus_name
  event_rule_name   = "${include.root.locals.naming_prefix}-${local.account_vars.account_name}-input"
  event_pattern     = <<PATTERN
{
	"detail-type" : [
      "ASDF"
    ]
}
PATTERN
  event_target_name = "${include.root.locals.naming_prefix}-${local.account_vars.account_name}-input"
  target_arn        = dependency.loggroup_eventbus.outputs.log_group_arn
}
