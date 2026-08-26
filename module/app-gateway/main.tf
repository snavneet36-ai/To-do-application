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

# ==========================================================
# WAF POLICY
# ==========================================================

resource "azurerm_web_application_firewall_policy" "this" {
  name                = "${var.app_gateway_name}-waf-policy"
  location            = var.location
  resource_group_name = var.resource_group_name

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    max_request_body_size_in_kb = 128
    file_upload_limit_in_mb     = 100
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# ==========================================================
# APPLICATION GATEWAY
# ==========================================================

resource "azurerm_application_gateway" "this" {
  name                = var.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Attach WAF Policy
  firewall_policy_id = azurerm_web_application_firewall_policy.this.id

  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 3
  }

  # ========================================================
  # Gateway Subnet
  # ========================================================

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_id
  }

  # ========================================================
  # Frontend
  # ========================================================

  frontend_ip_configuration {
    name                 = "public-frontend"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  # ========================================================
  # Backend App Service
  # ========================================================

  backend_address_pool {
    name  = "app-service-backend"
    fqdns = [var.backend_hostname]
  }

  # ========================================================
  # Health Probe
  # ========================================================

  probe {
    name                = "app-service-health-probe"
    protocol            = "Https"
    path                = "/"
    interval            = 30
    timeout             = 20
    unhealthy_threshold = 3
    host                = var.backend_hostname
  }

  # ========================================================
  # Backend HTTP Settings
  # ========================================================

  backend_http_settings {
    name                  = "app-service-https-settings"
    cookie_based_affinity = "Disabled"

    port     = 443
    protocol = "Https"

    request_timeout = 30

    probe_name = "app-service-health-probe"
    host_name  = var.backend_hostname
  }

  # ========================================================
  # HTTP Listener
  # No SSL certificate required
  # ========================================================

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "public-frontend"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  # ========================================================
  # Routing Rule
  # ========================================================

  request_routing_rule {
    name                       = "app-service-routing-rule"
    priority                   = 100
    rule_type                  = "Basic"

    http_listener_name         = "http-listener"
    backend_address_pool_name  = "app-service-backend"
    backend_http_settings_name = "app-service-https-settings"
  }

  # ========================================================
  # Tags
  # ========================================================

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}