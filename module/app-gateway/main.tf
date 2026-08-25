resource "azurerm_public_ip" "this" {
  name                = "${var.app_gateway_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}


resource "azurerm_application_gateway" "this" {
  name                = var.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 3
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "public-frontend"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  backend_address_pool {
    name  = "app-service-backend"
    fqdns = [var.backend_hostname]
  }

  probe {
    name                = "app-service-health-probe"
    protocol            = "Http"
    path                = "/"
    interval            = 30
    timeout             = 20
    unhealthy_threshold = 3

    host = var.backend_hostname
  }

  backend_http_settings {
    name                  = "app-service-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30

    probe_name = "app-service-health-probe"

    host_name = var.backend_hostname
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "public-frontend"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "app-service-routing-rule"
    priority                   = 100
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "app-service-backend"
    backend_http_settings_name = "app-service-http-settings"
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }

  backend_http_settings {
    name                  = "app-service-https-settings"
    cookie_based_affinity = "Disabled"

    port     = 443
    protocol = "Https"

    request_timeout = 30

    probe_name = "app-service-health-probe"

    host_name = var.backend_hostname
  }

  probe {
    name     = "app-service-health-probe"
    protocol = "Https"
    path     = "/"

    interval            = 30
    timeout             = 20
    unhealthy_threshold = 3

    host = var.backend_hostname
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}