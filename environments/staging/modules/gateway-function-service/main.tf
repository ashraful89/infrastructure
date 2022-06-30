locals {
  app_name = "${var.environment}-Ucan-gateway"
}

# Consumption Plan. Serverless, scales automatically with the number of events. No events => zero instances (you pay nothing).

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "${local.app_name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "FunctionApp"
  reserved            = true # this has to be set to true for Linux. Not related to the Premium Plan
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

# Premium Plan. You reserve a number of always-ready instances which run no matter if there are events or not. As load grows, new instances are added automatically.

# resource "azurerm_app_service_plan" "app_service_plan" {
# name                = "${local.app_name}-app-service-plan"
# resource_group_name = var.resource_group_name
# location            = var.location
# kind                = "FunctionApp"
#   kind     = "elastic"
#   reserved = true
#   sku {
#     tier = "ElasticPremium"
#     size = "EP1"
#   }
# }

resource "azurerm_function_app" "function_app" {
  name                = "${local.app_name}-fun-app"
  resource_group_name = var.resource_group_name
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  app_settings = {
    # There is some nuances to selecting the app settings related to service plan: https://github.com/Azure/functions-action/issues/58
    "SCM_DO_BUILD_DURING_DEPLOYMENT"         = 1,
    "ENABLE_ORYX_BUILD"                      = 1,
    "FUNCTIONS_WORKER_RUNTIME"               = "node",
    "APPINSIGHTS_INSTRUMENTATIONKEY"         = var.instrumentation_key,
    "CONTENTFUL_ENDPOINT"                    = var.contentful_endpoint,
    "CONTENTFUL_DELIVERY_TOKEN"              = var.contentful_delivery_token,
    "MONDAYCOM_ENDPOINT"                     = var.mondaycom_endpoint,
    "MONDAYCOM_API_TOKEN"                    = var.mondaycom_api_token,
    "MONDAYCOM_BENEFICIARY_BOARD_ID"         = var.mondaycom_beneficiary_board_id,
    "MONDAYCOM_BENEFICIARY_AD_ID_COLUMN_ID"  = var.mondaycom_beneficiary_ad_id_column_id,
    "MONDAYCOM_BENEFICIARY_STATUS_COLUMN_ID" = var.mondaycom_beneficiary_status_column_id,
    "AAD_CLIENT_SECRET"                      = var.aad_client_secret,
    "AAD_CLIENT_ID"                          = var.aad_client_id,
    "AAD_TENANT_ID"                          = var.aad_tenant_id,
    "AAD_EXTENSION_APP_CLIENT_ID"            = var.aad_extension_app_client_id,
    "AAD_ENDPOINT"                           = var.aad_endpoint,
    "GRAPH_ENDPOINT"                         = var.graph_endpoint
  }
  os_type = "linux"
  site_config {
    linux_fx_version          = "node|14"
    use_32_bit_worker_process = false
  }
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  version                    = "~4"

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}
