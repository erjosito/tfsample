terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

# Use the vnet module to create a virtual network with two subnets
module "vnet" {
  source        = "../../../modules/vnet"
  vnet_name     = var.vnet_name
  address_space = var.address_space
  location      = var.location
  rg            = var.rg
  environment   = var.environment
  subnet_name   = var.primary_subnet_name
  subnet_prefix = var.primary_subnet_prefix
}

# Create a second subnet directly (not through the module)
resource "azurerm_subnet" "secondary" {
  name                 = var.secondary_subnet_name
  resource_group_name  = var.rg
  virtual_network_name = module.vnet.vnet_id
  address_prefixes     = [var.secondary_subnet_prefix]
}
