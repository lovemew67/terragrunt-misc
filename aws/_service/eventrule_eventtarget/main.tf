module "cloudwatch_event_rule" {
  source = "git::https://github.com/lovemew67/terraform-misc.git//aws/modules/cloudwatch_event_rule?ref=v0.0.1"

  event_rule_name = var.event_rule_name
  event_bus_name  = var.event_bus_name
  event_pattern   = var.event_pattern
}

module "cloudwatch_event_target" {
  source = "git::https://github.com/lovemew67/terraform-misc.git//aws/modules/cloudwatch_event_target?ref=v0.0.1"

  event_bus_name    = var.event_bus_name
  event_rule_name   = var.event_rule_name
  event_target_name = var.event_target_name
  target_arn        = var.target_arn

  depends_on = [
    module.cloudwatch_event_rule
  ]
}
