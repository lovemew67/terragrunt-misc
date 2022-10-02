locals {
  env_region         = get_env("TF_VAR_env_region")
  env_project_name   = get_env("TF_VAR_env_project_name")
  env_workspace_name = get_env("TF_VAR_env_workspace_name", "default")

  naming_prefix = "${local.env_project_name}-${local.env_workspace_name}"
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
