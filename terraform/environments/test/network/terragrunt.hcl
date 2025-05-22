include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules//vnet"
}

locals {
  shared_inputs = include.root.inputs
}

inputs = merge(local.shared_inputs,
    {
    vnet_name              = "test-hub-vnet"
    address_space           = ["10.1.0.0/16"]
    primary_subnet_name    = "test-primary-subnet"
    primary_subnet_prefix   = "10.2.1.0/24"
    secondary_subnet_name  = "test-secondary-subnet" 
    secondary_subnet_prefix = "10.2.2.0/24"
    }
)