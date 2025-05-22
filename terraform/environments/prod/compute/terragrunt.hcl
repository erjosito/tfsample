include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules//vm"
}

dependency "network" {
  config_path = "../network"
  mock_outputs = {
    subnet_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnetValue"
  }
}

locals {
  akv_vars                     = read_terragrunt_config(find_in_parent_folders("keyvault.hcl"))
  akv_name                     = local.akv_vars.locals.akv_name
  akv_rg                       = local.akv_vars.locals.akv_rg
}

# Generate a data file with reference to the Key Vault
# Creates the following variables from AKV secrets:
# - defaultsecret -> vm_admin_password
# - defaultsshpublickey -> ssh_public_key
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
data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "defaultsshpublickey"
  key_vault_id = data.azurerm_key_vault.tfvalues.id
}
EOF
}

locals {
  env_vars                     = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment                  = local.env_vars.locals.environment
  location                     = local.env_vars.locals.location
  rg                           = local.env_vars.locals.rg
}

inputs = {
  # Required inputs
  environment            = local.environment
  location               = local.location
  rg                     = local.rg
  vm_name                = "${local.environment}-app-vm"
  vnet_subnet_id         = dependency.network.outputs.subnet_id
  
  # VM configuration
  vm_count               = 2
  vm_size                = "Standard_B1ms"
  admin_username         = "jose"
  
  # Authentication - Using SSH key is recommended over password for better security
  # Note: In a production environment, you should store these in Key Vault and retrieve them securely
  admin_password         = data.azurerm_key_vault_secret.vm_admin_password.value
  ssh_public_key         = data.azurerm_key_vault_secret.ssh_public_key.value
  
  # Networking configuration
  create_public_ip       = true
  domain_name_label      = "${local.environment}-app"
  
  # High availability configuration
  availability_set_enabled = true
  fault_domain_count     = 3  # Increased from default of 2 for better fault tolerance
  update_domain_count    = 5
  
  # Storage configuration
  os_disk_type           = "Premium_LRS"  # Changed to Premium storage for better performance
  os_disk_size_gb        = 50
  
  # OS image configuration
  os_image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  
  # Optional: Enable boot diagnostics for VM monitoring and troubleshooting
  # boot_diagnostics_storage_account = dependency.storage.outputs.primary_blob_endpoint # Uncomment when storage dependency exists
  
  # Resource tagging for organization and cost tracking
  tags = {
    Application = "WebApp"
    CostCenter  = "IT"
    Project     = "Terraform Sample"
    Environment = local.environment
    ManagedBy   = "Terraform"
  }
}
