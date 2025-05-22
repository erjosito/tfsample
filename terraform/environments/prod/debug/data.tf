data "azurerm_key_vault" "tfvalues" {
  name                = "tfvalues"
  resource_group_name = "terraform"
}
data "azurerm_key_vault_secret" "admin_password" {
  name         = "defaultpassword"
  key_vault_id = data.azurerm_key_vault.tfvalues.id
}
data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "defaultsshpublickey"
  key_vault_id = data.azurerm_key_vault.tfvalues.id
}
