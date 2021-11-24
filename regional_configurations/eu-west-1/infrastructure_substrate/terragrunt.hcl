locals {
    terraform_config = read_terragrunt_config(find_in_parent_folders("terraform_config.hcl"))
    tag = local.terraform_config.locals.tag
    # Environment configuration
    environment_specific_config = read_terragrunt_config(find_in_parent_folders("environment_specific.hcl")) 
    token = local.environment_specific_config.locals.environment
}


terraform {
    source = "git::git@github.com:cloud-native-skunkworks/ohmyyaml.git//civo?ref=${local.tag}"
}

inputs = {

}