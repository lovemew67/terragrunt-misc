include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "${dirname(find_in_parent_folders())}/_module/eventbridge_bus"
}

inputs = {
  naming_prefix = include.root.locals.naming_prefix
}
