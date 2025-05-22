module "debug" {
    source = "../../../modules//debug"
    input_string     = data.azurerm_key_vault_secret.admin_password.value
}