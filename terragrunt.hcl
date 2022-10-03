locals {
  env_region         = get_env("TF_VAR_env_region")
  env_project_name   = get_env("TF_VAR_env_project_name")
  env_workspace_name = get_env("TF_VAR_env_workspace_name", "default")

  env_state_address  = get_env("TF_VAR_env_state_address")
  env_state_username = get_env("TF_VAR_env_state_username")
  env_state_password = get_env("TF_VAR_env_state_password")

  env_gcs_bucket          = get_env("TF_VAR_env_gcs_bucket")
  env_gcs_project         = get_env("TF_VAR_env_gcs_project")
  env_gcs_bucket_location = get_env("TF_VAR_env_gcs_bucket_location")

  naming_prefix  = "${local.env_project_name}-${local.env_workspace_name}-terragrunt"
  backend_addrss = "${local.env_state_address}/terraform/state/terragrunt_${local.env_project_name}_${local.env_workspace_name}"
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
  backend = "gcs"
  config = {
    prefix = "terragrunt/version2/${path_relative_to_include()}"

    bucket   = local.env_gcs_bucket
    project  = local.env_gcs_project
    location = local.env_gcs_bucket_location
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
