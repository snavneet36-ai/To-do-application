output "application_gateway_id" {
  description = "Application Gateway resource ID"
  value       = azurerm_application_gateway.this.id
}

output "application_gateway_name" {
  description = "Application Gateway name"
  value       = azurerm_application_gateway.this.name
}

output "public_ip_address" {
  description = "Application Gateway public IP"
  value       = azurerm_public_ip.this.ip_address
}