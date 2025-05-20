variable "location" {
  description = "The Azure region to deploy resources into."
  type        = string
}

variable "rg" {
  description = "The name of the resource group."
  type        = string
}

variable "vnet_subnet_id" {
  description = "The subnet ID for the VM network interface."
  type        = string
}

variable "environment" {
  description = "The environment for resource tagging (e.g., dev, staging, prod)."
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
  default     = "sample-vm"
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_B1s"
}
