locals {
  app_name = "ucan-${var.environment}"
}

resource "azurerm_frontdoor_firewall_policy" "static_web_app_waf" {
  name                              = "staticAppFdwafpolicy"
  resource_group_name               = var.resource_group_name
  enabled                           = true
  mode                              = "Prevention"

  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"

    exclusion {
      match_variable = "QueryStringArgNames"
      operator       = "Equals"
      selector       = "not_suspicious"
    }
  }

  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
  }
}

resource "azurerm_frontdoor" "static_web_app" {
  name                = "${local.app_name}-frontdoor-endpoint"
  resource_group_name = var.resource_group_name
  enforce_backend_pools_certificate_name_check = true

  routing_rule {
    name               = "${local.app_name}RoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = [
      "${local.app_name}-frontdoor-endpoint",
      var.environment == "production" ? "www-ucan-savethechildren-org" : "www-staging-ucan-savethechildren-org"
      ]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "${local.app_name}BackendPool"
    }
  }

  backend_pool_load_balancing {
    name = "${local.app_name}LoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "${local.app_name}HealthProbeSetting1"
  }

  backend_pool {
    name = "${local.app_name}BackendPool"
    backend {
      host_header = var.static_web_app_host
      address     = var.static_web_app_host
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "${local.app_name}LoadBalancingSettings1"
    health_probe_name   = "${local.app_name}HealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "${local.app_name}-frontdoor-endpoint"
    host_name = "${local.app_name}-frontdoor-endpoint.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.static_web_app_waf.id
  }

  frontend_endpoint {
    name                                    = var.environment == "production" ? "www-ucan-savethechildren-org" : "www-staging-ucan-savethechildren-org"
    host_name                               = var.environment == "production" ? "www.ucan-savethechildren.org" : "www.staging.ucan-savethechildren.org"
    session_affinity_enabled                = false
    session_affinity_ttl_seconds            = 0
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.static_web_app_waf.id
  }
}

