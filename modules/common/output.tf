output "azurerm_resource_group" {
  value = azurerm_resource_group.env_resource_group
}

output "tenant_id" {
  value = azurerm_aadb2c_directory.ad-b2c-tenant.tenant_id
}