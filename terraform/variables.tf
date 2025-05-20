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
