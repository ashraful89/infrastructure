output "instrumentation_key" {
  value = azurerm_application_insights.gateway_application_insights.instrumentation_key
}

output "application_insights_id" {
  value = azurerm_application_insights.gateway_application_insights.id
}