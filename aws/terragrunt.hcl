locals {
  env_region         = get_env("TF_VAR_env_region")
  env_project_name   = get_env("TF_VAR_env_project_name")
  env_workspace_name = get_env("TF_VAR_env_workspace_name", "default")

  env_state_address  = get_env("TF_VAR_env_state_address")
  env_state_username = get_env("TF_VAR_env_state_username")
  env_state_password = get_env("TF_VAR_env_state_password")

  sub_dir = trimprefix(get_terragrunt_dir(), dirname(find_in_parent_folders("account.hcl")))

  naming_prefix  = "${local.env_project_name}-${local.env_workspace_name}-terragrunt"
  backend_addrss = "${local.env_state_address}/terraform/state/terragrunt_${local.env_project_name}_${local.env_workspace_name}_module_${split("/", local.sub_dir)[1]}_${split("/", local.sub_dir)[2]}"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.env_region}"
}
EOF
}

remote_state {
  backend = "http"
  config = {
    address        = local.backend_addrss
    lock_address   = "${local.backend_addrss}/lock"
    unlock_address = "${local.backend_addrss}/lock"
    username       = local.env_state_username
    password       = local.env_state_password
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
