// File removed: replaced by Terragrunt configuration.

variable "location" {
  description = "The Azure region to deploy resources into."
  type        = string
  default     = "eastus"
}

variable "rg" {
  description = "The name of the resource group."
  type        = string
}

variable "environment" {
  description = "The environment for resource tagging (e.g., dev, staging, prod)."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "sample-vnet"
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
  default     = "sample-subnet"
}

variable "subnet_prefix" {
  description = "The address prefix for the subnet."
  type        = string
  default     = "10.0.1.0/24"
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

variable "admin_password" {
  description = "The admin password for the virtual machine."
  type        = string
  sensitive   = true
}

variable "vm_count" {
  description = "Number of VMs to deploy."
  type        = number
  default     = 2
}

variable "alb_name" {
  description = "The name of the Azure Load Balancer."
  type        = string
  default     = "alb"
}

variable "public_ip_name" {
  description = "The name for the public IP resource."
  type        = string
  default     = "alb-public-ip"
}
