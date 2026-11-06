variable "resource_group_name" {
  description = "Existing DEV resource group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "vm_name" {
  description = "Monitoring Linux VM name."
  type        = string
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
}

variable "admin_username" {
  description = "Linux VM administrator username."
  type        = string
}

variable "ssh_public_key" {
  description = "Administrator SSH public key."
  type        = string

  validation {
    condition     = startswith(var.ssh_public_key, "ssh-ed25519 ")
    error_message = "An Ed25519 SSH public key is required."
  }
}

variable "subnet_id" {
  description = "Dedicated monitoring subnet ID."
  type        = string
}

variable "tags" {
  description = "Tags applied to Linux VM resources."
  type        = map(string)
}
