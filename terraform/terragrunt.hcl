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

# Common provider configuration can be added here if needed

# Shared data sources for Key Vault secret retrieval

data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.env.id
}

data "azurerm_key_vault" "env" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}
