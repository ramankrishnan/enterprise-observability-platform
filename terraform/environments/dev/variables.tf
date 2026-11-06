variable "subscription_id" {
  description = "Azure subscription ID used by this environment."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for the development environment."
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the development resource group."
  type        = string
  default     = "rg-enterprise-observability-dev"
}

variable "vnet_name" {
  description = "Name of the development virtual network."
  type        = string
  default     = "vnet-observability-dev"
}

variable "vnet_address_space" {
  description = "Address space assigned to the development environment."
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the existing development subnet."
  type        = string
  default     = "snet-observability-dev"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes of the existing development subnet."
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "nsg_name" {
  description = "Name of the existing development NSG."
  type        = string
  default     = "nsg-observability-dev"
}

variable "monitoring_subnet_name" {
  description = "Dedicated monitoring subnet name."
  type        = string
  default     = "snet-monitoring-dev"
}

variable "monitoring_subnet_address_prefixes" {
  description = "Monitoring subnet address range."
  type        = list(string)
  default     = ["10.20.2.0/24"]
}

variable "monitoring_nsg_name" {
  description = "Dedicated monitoring NSG name."
  type        = string
  default     = "nsg-monitoring-dev"
}

variable "admin_ssh_cidr" {
  description = "Administrator public IP allowed to SSH."
  type        = string
}

variable "monitoring_vm_name" {
  description = "Monitoring Linux VM name."
  type        = string
  default     = "vm-observability-monitor"
}

variable "monitoring_vm_size" {
  description = "Monitoring VM size."
  type        = string
  default     = "Standard_D4als_v6"
}

variable "monitoring_admin_username" {
  description = "Linux VM administrator username."
  type        = string
  default     = "azureadmin"
}

variable "monitoring_ssh_public_key" {
  description = "Ed25519 public key used for SSH authentication."
  type        = string
  sensitive   = true
}

variable "common_tags" {
  description = "Tags applied to development resources."
  type        = map(string)

  default = {
    project     = "enterprise-observability-platform"
    environment = "dev"
    managed_by  = "terraform"
  }
}
