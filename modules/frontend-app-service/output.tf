output "azurerm_static_site_id" {
  value = azurerm_static_site.web.id
}

output "azurerm_static_site_api_key" {
  value = azurerm_static_site.web.api_key
}

output "azurerm_static_site_default_host_name" {
  value = azurerm_static_site.web.default_host_name 
}
