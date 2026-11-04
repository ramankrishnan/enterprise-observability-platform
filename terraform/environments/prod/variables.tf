variable "subscription_id" {
  description = "Azure subscription ID used by PROD."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for the PROD environment."
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the PROD resource group."
  type        = string
  default     = "rg-enterprise-observability-prod"
}

variable "vnet_name" {
  description = "Name of the PROD virtual network."
  type        = string
  default     = "vnet-observability-prod"
}

variable "vnet_address_space" {
  description = "Address space assigned to the PROD virtual network."
  type        = list(string)
  default     = ["10.60.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the PROD subnet."
  type        = string
  default     = "snet-observability-prod"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes assigned to the PROD subnet."
  type        = list(string)
  default     = ["10.60.1.0/24"]
}

variable "nsg_name" {
  description = "Name of the PROD network security group."
  type        = string
  default     = "nsg-observability-prod"
}

variable "common_tags" {
  description = "Tags applied to PROD resources."
  type        = map(string)
  default = {
    project     = "enterprise-observability-platform"
    environment = "prod"
    managed_by  = "terraform"
    criticality = "high"
  }
}
