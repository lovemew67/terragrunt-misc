output "log_group_arn" {
  value = module.cloudwatch_log_group.log_group_arn
}

output "event_bus_name" {
  value = module.cloudwatch_event_bus.event_bus_name
}
