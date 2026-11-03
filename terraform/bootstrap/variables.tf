variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  nullable    = false
}

variable "location" {
  description = "Azure region for Terraform state resources"
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Resource group for Terraform state"
  type        = string
  default     = "rg-enterprise-tfstate"
}

variable "storage_account_name" {
  description = "Dedicated storage account for Terraform state"
  type        = string
  default     = "ramanobsstate2026"
}

variable "container_name" {
  description = "Blob container for Terraform state"
  type        = string
  default     = "tfstate"
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)

  default = {
    project     = "enterprise-observability-platform"
    environment = "shared"
    managed_by  = "terraform"
    purpose     = "terraform-remote-state"
  }
}
