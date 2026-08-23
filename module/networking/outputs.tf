output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "app_gateway_subnet_id" {
  description = "ID of the Application Gateway subnet"
  value       = azurerm_subnet.app_gateway.id
}

output "app_gateway_subnet_name" {
  description = "Name of the Application Gateway subnet"
  value       = azurerm_subnet.app_gateway.name
}

output "app_service_subnet_id" {
  description = "ID of the App Service integration subnet"
  value       = azurerm_subnet.app_service.id
}

output "app_service_subnet_name" {
  description = "Name of the App Service integration subnet"
  value       = azurerm_subnet.app_service.name
}

output "nsg_id" {
  description = "ID of the Network Security Group"
  value       = azurerm_network_security_group.this.id
}

output "sql_vm_subnet_id" {
  description = "SQL VM subnet ID"
  value       = azurerm_subnet.sql_vm.id
}

