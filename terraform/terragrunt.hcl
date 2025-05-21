# Root Terragrunt configuration

remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate1138"
    container_name       = "tfstate"
    key                 = "${path_relative_to_include()}/terraform.tfstate"
  }
}

locals {
    location = "eastus2"
    parent = "${get_terragrunt_dir()}/../"
    env = basename(dirname(local.parent))
    rg = "${env}-rg"
    vnet_name = "${env}-vnet"
}

