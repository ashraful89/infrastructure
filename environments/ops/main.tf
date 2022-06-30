resource "azurerm_resource_group" "env_resource_group" {
  name     = "ARG${upper(local.environment)}"
  location = local.location
}
