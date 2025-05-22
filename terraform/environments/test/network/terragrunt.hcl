include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules//vnet"
}

locals {
  env_vars                     = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment                  = local.env_vars.locals.environment
  location                     = local.env_vars.locals.location
  rg                           = local.env_vars.locals.rg
}

inputs =  {
    environment            = local.environment
    location               = local.location
    rg                     = local.rg
    vnet_name              = "${local.environment}-hub-vnet"
    address_space          = ["10.2.0.0/16"]
    subnet_name            = "${local.environment}-subnet00"
    subnet_prefix          = "10.2.0.0/24"
}
