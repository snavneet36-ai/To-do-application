variable "vnet_name" {
  type        = string
  description = "Name of the VNet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "VNet address space"
}

variable "app_gateway_subnet_name" {
  type        = string
  description = "Application Gateway subnet name"
}

variable "app_gateway_subnet_address_prefixes" {
  type        = list(string)
  description = "Application Gateway subnet CIDR"
}

variable "app_service_subnet_name" {
  type        = string
  description = "App Service subnet name"
}

variable "app_service_subnet_address_prefixes" {
  type        = list(string)
  description = "App Service subnet CIDR"
}

variable "nsg_name" {
  type        = string
  description = "Network Security Group name"
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "app_service_plan_name" {
  description = "App Service Plan name"
  type        = string
}

variable "app_service_name" {
  description = "Linux Web App name"
  type        = string
}

variable "app_service_sku" {
  description = "App Service Plan SKU"
  type        = string
  default     = "B1"
}

variable "key_vault_name" {
  description = "Key Vault name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "app_gateway_name" {
  description = "Application Gateway name"
  type        = string
}
variable "sql_vm_subnet_name" {
  description = "Subnet name for SQL Server VM"
  type        = string
}

variable "sql_vm_subnet_address_prefixes" {
  description = "Address prefixes for SQL Server VM subnet"
  type        = list(string)
}



variable "sql_vm_size" {
  description = "SQL Server VM size"
  type        = string
  default     = "Standard_B2s"
}

variable "sql_vm_admin_username" {
  description = "SQL VM administrator username"
  type        = string
  sensitive   = true
}



variable "sql_vm_name" {
  description = "SQL Server VM name"
  type        = string
}

variable "private_endpoint_subnet_name" {
  description = "Private endpoint subnet name"
  type        = string
}

variable "private_endpoint_subnet_address_prefixes" {
  description = "Private endpoint subnet CIDR"
  type        = list(string)
}

variable "sql_vm_password_expiration_date" {
  description = "Expiration date for SQL VM administrator password"
  type        = string
}