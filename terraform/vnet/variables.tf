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

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "sample-vnet"
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
