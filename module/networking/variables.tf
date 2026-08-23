variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "app_gateway_subnet_name" {
  description = "Name of the Application Gateway subnet"
  type        = string
}

variable "app_gateway_subnet_address_prefixes" {
  description = "Address prefixes for Application Gateway subnet"
  type        = list(string)
}

variable "app_service_subnet_name" {
  description = "Name of the App Service integration subnet"
  type        = string
}

variable "app_service_subnet_address_prefixes" {
  description = "Address prefixes for App Service subnet"
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "app_gateway_subnet_nsg_rules" {
  description = "NSG rules for Application Gateway subnet"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "app_service_subnet_nsg_rules" {
  description = "NSG rules for App Service subnet"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "sql_vm_subnet_name" {
  description = "SQL VM subnet name"
  type        = string
}

variable "sql_vm_subnet_address_prefixes" {
  description = "SQL VM subnet address prefixes"
  type        = list(string)
}

