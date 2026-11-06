output "resource_group_name" {
  description = "Development resource group name."
  value       = module.resource_group.name
}

output "virtual_network_name" {
  description = "Development virtual network name."
  value       = module.networking.virtual_network_name
}

output "virtual_network_address_space" {
  description = "Development virtual network address space."
  value       = module.networking.virtual_network_address_space
}

output "subnet_name" {
  description = "Development subnet name."
  value       = module.networking.subnet_name
}

output "subnet_address_prefixes" {
  description = "Development subnet address prefixes."
  value       = module.networking.subnet_address_prefixes
}

output "network_security_group_name" {
  description = "Development network security group name."
  value       = module.networking.network_security_group_name
}

output "monitoring_subnet_name" {
  description = "Dedicated monitoring subnet name."
  value       = module.monitoring_network.subnet_name
}

output "monitoring_subnet_address_prefixes" {
  description = "Monitoring subnet address prefixes."
  value       = module.monitoring_network.subnet_address_prefixes
}

output "monitoring_nsg_name" {
  description = "Monitoring NSG name."
  value       = module.monitoring_network.network_security_group_name
}

output "monitoring_vm_name" {
  description = "Monitoring VM name."
  value       = module.monitoring_vm.vm_name
}

output "monitoring_vm_private_ip" {
  description = "Monitoring VM private IP."
  value       = module.monitoring_vm.private_ip_address
}

output "monitoring_vm_public_ip" {
  description = "Monitoring VM public IP."
  value       = module.monitoring_vm.public_ip_address
}
