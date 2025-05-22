# Root Terragrunt configuration
# Load backend configuration from the backend.hcl file (in 'environments' folder)
# Load AKV variables from the keyvault.hcl file (in 'environments' folder)
# Load specific env information from env.hcl (in each env's folder)
locals {
  backend_config               = read_terragrunt_config(find_in_parent_folders("backend.hcl"))
  backend_container_name       = local.backend_config.locals.container_name
  backend_resource_group_name  = local.backend_config.locals.resource_group_name
  backend_storage_account_name = local.backend_config.locals.storage_account_name
  env_vars                     = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  subscription_id              = local.env_vars.locals.subscription_id
  akv_vars                     = read_terragrunt_config(find_in_parent_folders("keyvault.hcl"))
  akv_name                     = local.akv_vars.locals.akv_name
  akv_rg                       = local.akv_vars.locals.akv_rg
}

# Generate an Azure provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
    subscription_id = "${local.subscription_id}"
}
EOF
}

# Generate a backend block
remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    subscription_id      = local.subscription_id
    resource_group_name  = local.backend_resource_group_name
    storage_account_name = local.backend_storage_account_name
    container_name       = local.backend_container_name
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

# Generate a Terraform required providers file
generate "terraform" {
  path      = "required_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}
EOF
}

# Generate a data file with reference to the Key Vault
# Creates the following variables from AKV secrets:
# - -> vm_admin_password
generate "data" {
  path      = "data.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
data "azurerm_key_vault" "tfvalues" {
  name                = "${local.akv_name}"
  resource_group_name = "${local.akv_rg}"
}
data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = "defaultpassword"
  key_vault_id = data.azurerm_key_vault.tfvalues.id
}
EOF
}

# Get shared variables and provide as inputs
inputs = local.env_vars