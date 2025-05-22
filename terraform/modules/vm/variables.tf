variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_B1s"
}

variable "location" {
  description = "The Azure region to deploy resources into."
  type        = string
}

variable "rg" {
  description = "The name of the resource group."
  type        = string
}

variable "environment" {
  description = "The environment for resource tagging (e.g., dev, staging, prod)."
  type        = string
}

variable "vnet_subnet_id" {
  description = "The subnet ID for the VM network interface."
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the virtual machines."
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "The administrator password for the virtual machines. If not provided, SSH key will be required."
  type        = string
  sensitive   = true
  default     = null
}

variable "ssh_public_key" {
  description = "The SSH public key for the admin user. Required if admin_password is null."
  type        = string
  default     = null
  sensitive   = true
}

variable "vm_count" {
  description = "Number of VMs to deploy."
  type        = number
  default     = 1
}

variable "os_image" {
  description = "The OS image to use for the VM."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

variable "os_disk_type" {
  description = "The type of OS disk to create."
  type        = string
  default     = "Standard_LRS"
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in gigabytes."
  type        = number
  default     = 30
}

variable "create_public_ip" {
  description = "Whether to create public IP addresses for the virtual machines."
  type        = bool
  default     = false
}

variable "domain_name_label" {
  description = "The prefix for the DNS name of the public IPs. Will be appended with the VM index."
  type        = string
  default     = null
}

variable "availability_set_enabled" {
  description = "Whether to create an availability set for the virtual machines."
  type        = bool
  default     = false
}

variable "fault_domain_count" {
  description = "The number of fault domains for the availability set."
  type        = number
  default     = 2
}

variable "update_domain_count" {
  description = "The number of update domains for the availability set."
  type        = number
  default     = 5
}

variable "boot_diagnostics_storage_account" {
  description = "URI of the storage account for boot diagnostics."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to be applied to the resources."
  type        = map(string)
  default     = {}
}