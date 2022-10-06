include "root" {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
}

terraform {
  source = "${dirname(find_in_parent_folders())}/_service/loggroup_eventbus"
}

inputs = {
  log_group_name = "/aws/events/${include.root.locals.naming_prefix}-${local.account_vars.account_name}-input"
  event_bus_name = "${include.root.locals.naming_prefix}-${local.account_vars.account_name}-input"
}
