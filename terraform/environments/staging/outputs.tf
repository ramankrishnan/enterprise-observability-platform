output "resource_group_name" {
  description = "STAGING resource group name."
  value       = module.resource_group.name
}

output "virtual_network_name" {
  description = "STAGING virtual network name."
  value       = module.networking.virtual_network_name
}

output "virtual_network_address_space" {
  description = "STAGING virtual network address space."
  value       = module.networking.virtual_network_address_space
}

output "subnet_name" {
  description = "STAGING subnet name."
  value       = module.networking.subnet_name
}

output "subnet_address_prefixes" {
  description = "STAGING subnet address prefixes."
  value       = module.networking.subnet_address_prefixes
}

output "network_security_group_name" {
  description = "STAGING network security group name."
  value       = module.networking.network_security_group_name
}
