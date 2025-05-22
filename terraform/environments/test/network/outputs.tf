output "vnet_id" {
  description = "The ID of the deployed virtual network."
  value       = module.vnet.vnet_id
}

output "primary_subnet_id" {
  description = "The ID of the primary subnet."
  value       = module.vnet.subnet_id
}

output "secondary_subnet_id" {
  description = "The ID of the secondary subnet."
  value       = azurerm_subnet.secondary.id
}
