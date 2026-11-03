output "resource_group_name" {
  description = "Development resource group name."
  value       = azurerm_resource_group.dev.name
}

output "virtual_network_name" {
  description = "Development virtual network name."
  value       = azurerm_virtual_network.dev.name
}

output "virtual_network_address_space" {
  description = "Development virtual network address space."
  value       = azurerm_virtual_network.dev.address_space
}

output "subnet_name" {
  description = "Development subnet name."
  value       = azurerm_subnet.dev.name
}

output "subnet_address_prefixes" {
  description = "Development subnet address prefixes."
  value       = azurerm_subnet.dev.address_prefixes
}

output "network_security_group_name" {
  description = "Development network security group name."
  value       = azurerm_network_security_group.dev.name
}
