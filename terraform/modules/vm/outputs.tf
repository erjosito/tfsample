output "vm_id" {
  value = azurerm_linux_virtual_machine.this.id
}

output "nic_ids" {
  value = azurerm_network_interface.this[*].id
}