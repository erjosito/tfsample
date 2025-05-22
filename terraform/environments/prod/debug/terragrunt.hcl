include "root" {
  path = find_in_parent_folders()
}

# terraform {
#   source = "${get_parent_terragrunt_dir()}/modules//debug"
# }

# locals {
#   akv_vars                     = read_terragrunt_config(find_in_parent_folders("keyvault.hcl"))
#   akv_name                     = local.akv_vars.locals.akv_name
#   akv_rg                       = local.akv_vars.locals.akv_rg
# }

# generate "data" {
#   path      = "data.tf"
#   if_exists = "overwrite_terragrunt"
#   contents  = <<EOF
# data "azurerm_key_vault" "tfvalues" {
#   name                = "${local.akv_name}"
#   resource_group_name = "${local.akv_rg}"
# }
# data "azurerm_key_vault_secret" "vm_admin_password" {
#   name         = "defaultpassword"
#   key_vault_id = data.azurerm_key_vault.tfvalues.id
# }
# data "azurerm_key_vault_secret" "ssh_public_key" {
#   name         = "defaultsshpublickey"
#   key_vault_id = data.azurerm_key_vault.tfvalues.id
# }
# EOF
# }
