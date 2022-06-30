resource "azurerm_application_insights" "gateway_application_insights" {
  name                = "${var.environment}-Ucan-gateway-application-insights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "Node.JS"
}