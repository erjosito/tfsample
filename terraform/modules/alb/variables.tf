variable "location" {
  description = "The Azure region to deploy resources into."
  type        = string
}

variable "rg" {
  description = "The name of the resource group."
  type        = string
}

variable "frontend_subnet_id" {
  description = "The subnet ID for the internal load balancer frontend."
  type        = string
}

variable "backend_nic_ids" {
  description = "List of NIC IDs to add to the backend pool."
  type        = list(string)
}

variable "public_ip_name" {
  description = "The name for the public IP resource."
  type        = string
  default     = "alb-public-ip"
}

variable "lb_name" {
  description = "The name for the load balancer."
  type        = string
  default     = "alb"
}
