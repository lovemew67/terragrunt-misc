module "cloudwatch_log_group" {
  source = "git::https://github.com/lovemew67/terraform-misc.git//aws/modules/cloudwatch_log_group?ref=v0.0.1"

  log_group_name = var.log_group_name
}

module "cloudwatch_event_bus" {
  source = "git::https://github.com/lovemew67/terraform-misc.git//aws/modules/cloudwatch_event_bus?ref=v0.0.1"

  event_bus_name = var.event_bus_name
}
