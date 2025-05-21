data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.env.id
}

data "azurerm_key_vault" "env" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}