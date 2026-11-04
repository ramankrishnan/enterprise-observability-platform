output "resource_group_name" {
  description = "QA resource group name."
  value       = module.resource_group.name
}

output "virtual_network_name" {
  description = "QA virtual network name."
  value       = module.networking.virtual_network_name
}

output "virtual_network_address_space" {
  description = "QA virtual network address space."
  value       = module.networking.virtual_network_address_space
}

output "subnet_name" {
  description = "QA subnet name."
  value       = module.networking.subnet_name
}

output "subnet_address_prefixes" {
  description = "QA subnet address prefixes."
  value       = module.networking.subnet_address_prefixes
}

output "network_security_group_name" {
  description = "QA network security group name."
  value       = module.networking.network_security_group_name
}
