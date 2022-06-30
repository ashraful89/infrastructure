#
# Common module resources per environment
# defined here.
#

resource "azurerm_resource_group" "env_resource_group" {
  name     = "ARG${upper(var.environment)}"
  location = var.location
}

resource "azurerm_resource_group" "env_resource_group_function_service" {
  name     = "ARG_FUN_${upper(var.environment)}"
  location = var.location
}

resource "azurerm_aadb2c_directory" "ad-b2c-tenant" {
  country_code            = "DE"
  data_residency_location = "Europe"
  display_name            = "ucan${var.environment}b2c"
  domain_name             = "ucan${var.environment}b2c.onmicrosoft.com"
  resource_group_name     = azurerm_resource_group.env_resource_group.name
  sku_name                = "PremiumP1"
}

#resource "azurerm_dns_zone" "domain" {
#  name                = var.domain_name
#  resource_group_name = azurerm_resource_group.env_resource_group.name
#}

module "application_insights" {
  source              = "../application-insights"
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.env_resource_group_function_service.name
}

module "gateway-function-service" {
  source                                 = "../gateway-function-service"
  location                               = var.location
  environment                            = var.environment
  resource_group_name                    = azurerm_resource_group.env_resource_group_function_service.name
  storage_account_name                   = module.fun_storage.account_name
  storage_account_access_key             = module.fun_storage.primary_access_key
  instrumentation_key                    = module.application_insights.instrumentation_key
  contentful_endpoint                    = var.contentful_endpoint
  contentful_delivery_token              = var.contentful_delivery_token
  mondaycom_endpoint                     = var.mondaycom_endpoint
  mondaycom_api_token                    = var.mondaycom_api_token
  mondaycom_beneficiary_ad_id_column_id  = var.mondaycom_beneficiary_ad_id_column_id
  mondaycom_beneficiary_board_id         = var.mondaycom_beneficiary_board_id
  mondaycom_beneficiary_status_column_id = var.mondaycom_beneficiary_status_column_id
  aad_client_secret                      = var.aad_client_secret
  aad_tenant_id                          = var.aad_tenant_id
  aad_client_id                          = var.aad_client_id
  aad_extension_app_client_id            = var.aad_extension_app_client_id
  aad_endpoint                           = var.aad_endpoint
  graph_endpoint                         = var.graph_endpoint
}

module "frontend-app-service" {
  source              = "../frontend-app-service"
  location            = var.location
  environment         = var.environment
  resource_group_name = azurerm_resource_group.env_resource_group.name
  #  domain_name                          = var.domain_name
}

module "fun_storage" {
  source                  = "../storage"
  environment             = var.environment
  resource_group_name     = azurerm_resource_group.env_resource_group_function_service.name
  resource_group_location = azurerm_resource_group.env_resource_group_function_service.location
}

module "ad-b2c-tenant" {
  source = "../ad-b2c-tenant"

  tenant_id          = azurerm_aadb2c_directory.ad-b2c-tenant.tenant_id
  tenant_domain_name = azurerm_aadb2c_directory.ad-b2c-tenant.domain_name
}

module "monitoring" {
  source              = "../monitor"
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.env_resource_group_function_service.name
  application_insights_id = module.application_insights.application_insights_id
  subscription_role_owner_id = var.subscription_role_owner_id
}

module "frontdoor" {
  source              = "../frontdoor"
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.env_resource_group.name
  static_web_app_host = module.frontend-app-service.azurerm_static_site_default_host_name
}
