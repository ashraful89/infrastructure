locals {
  app_name = "${var.environment}-Ucan-Frontend"
}

resource "azurerm_static_site" "web" {
  name = local.app_name
  resource_group_name = var.resource_group_name
  location = var.location
  sku_tier                        = "Standard"
  sku_size                        = "Standard"
}