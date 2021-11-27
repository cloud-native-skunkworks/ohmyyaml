locals {
    terraform_config = read_terragrunt_config(find_in_parent_folders("terraform_config.hcl"))
    tag = local.terraform_config.locals.tag
    # Environment configuration
    environment_specific_config = read_terragrunt_config(find_in_parent_folders("environment_specific.hcl")) 
    environment = local.environment_specific_config.locals.environment
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  provider "aws" {
    region = "${local.environment}"
  }
EOF
}

terraform {
    source = "git::git@github.com:cloud-native-skunkworks/ohmyyaml.git//module_catalogue/infrastructure_substrate?ref=${local.tag}"
}

inputs = {

}
