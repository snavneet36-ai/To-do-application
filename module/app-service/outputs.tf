output "app_service_id" {
  description = "App Service resource ID"
  value       = azurerm_linux_web_app.this.id
}

output "app_service_name" {
  description = "App Service name"
  value       = azurerm_linux_web_app.this.name
}

output "default_hostname" {
  description = "Default App Service hostname"
  value       = azurerm_linux_web_app.this.default_hostname
}

output "principal_id" {
  description = "Managed Identity principal ID"
  value       = azurerm_linux_web_app.this.identity[0].principal_id
}

output "tenant_id" {
  description = "Managed Identity tenant ID"
  value       = azurerm_linux_web_app.this.identity[0].tenant_id
}

output "app_service_plan_id" {
  description = "App Service Plan ID"
  value       = azurerm_service_plan.this.id
}

