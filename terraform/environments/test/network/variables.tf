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
  default     = "prod"
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "prod-vnet"
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "primary_subnet_name" {
  description = "The name of the primary subnet."
  type        = string
  default     = "primary-subnet"
}

variable "primary_subnet_prefix" {
  description = "The address prefix for the primary subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "secondary_subnet_name" {
  description = "The name of the secondary subnet."
  type        = string
  default     = "secondary-subnet"
}

variable "secondary_subnet_prefix" {
  description = "The address prefix for the secondary subnet."
  type        = string
  default     = "10.0.2.0/24"
}
