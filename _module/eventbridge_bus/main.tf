resource "aws_cloudwatch_event_bus" "main" {
  name = "${var.naming_prefix}-event-bus"
}
