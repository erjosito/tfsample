output "vnet_id" {
  description = "The ID of the deployed virtual network."
  value       = module.vnet.vnet_id
}

output "vm_id" {
  description = "The ID of the deployed virtual machine."
  value       = module.vm.vm_id
}
