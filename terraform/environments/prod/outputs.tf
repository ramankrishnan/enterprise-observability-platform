output "resource_group_name" {
  description = "PROD resource group name."
  value       = module.resource_group.name
}

output "virtual_network_name" {
  description = "PROD virtual network name."
  value       = module.networking.virtual_network_name
}

output "virtual_network_address_space" {
  description = "PROD virtual network address space."
  value       = module.networking.virtual_network_address_space
}

output "subnet_name" {
  description = "PROD subnet name."
  value       = module.networking.subnet_name
}

output "subnet_address_prefixes" {
  description = "PROD subnet address prefixes."
  value       = module.networking.subnet_address_prefixes
}

output "network_security_group_name" {
  description = "PROD network security group name."
  value       = module.networking.network_security_group_name
}
