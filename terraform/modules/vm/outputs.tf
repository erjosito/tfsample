output "vm_ids" {
  description = "The IDs of the deployed virtual machines."
  value       = azurerm_linux_virtual_machine.this[*].id
}

output "vm_names" {
  description = "The names of the deployed virtual machines."
  value       = azurerm_linux_virtual_machine.this[*].name
}

output "nic_ids" {
  description = "The IDs of the deployed network interfaces."
  value       = azurerm_network_interface.this[*].id
}

output "private_ip_addresses" {
  description = "The primary private IP addresses of the deployed virtual machines."
  value       = [for nic in azurerm_network_interface.this : nic.ip_configuration[0].private_ip_address]
}

output "public_ip_addresses" {
  description = "The public IP addresses of the deployed virtual machines (if enabled)."
  value       = var.create_public_ip ? [for ip in azurerm_public_ip.this : ip.ip_address] : []
}

output "public_fqdns" {
  description = "The fully qualified domain names of the deployed virtual machines (if enabled and domain_name_label is set)."
  value       = var.create_public_ip && var.domain_name_label != null ? [for ip in azurerm_public_ip.this : ip.fqdn] : []
}

output "availability_set_id" {
  description = "The ID of the availability set (if enabled)."
  value       = var.availability_set_enabled ? azurerm_availability_set.this[0].id : null
}