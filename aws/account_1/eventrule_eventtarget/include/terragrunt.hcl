include "root" {
  path = find_in_parent_folders()
}

include "include" {
  path = "${dirname(find_in_parent_folders())}/_service/eventrule_eventtarget/include.hcl"
}

terraform {
  source = "${dirname(find_in_parent_folders())}/_service/eventrule_eventtarget"
}
