terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Create test resource to verify Terragrunt is working
resource "azurerm_resource_group" "test" {
  name     = "test-${var.vnet_name}-rg"
  location = var.location
  tags = {
    Environment = var.environment
  }
}
