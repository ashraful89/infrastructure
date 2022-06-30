module "common" {
  source                                 = "./modules/common"
  environment                            = local.environment
  subscription_id                        = local.subscription_id
  contentful_endpoint                    = local.contentful_endpoint
  contentful_delivery_token              = var.contentful_delivery_token
  mondaycom_endpoint                     = local.mondaycom_endpoint
  mondaycom_api_token                    = var.mondaycom_api_token
  mondaycom_beneficiary_ad_id_column_id  = local.mondaycom_beneficiary_ad_id_column_id
  mondaycom_beneficiary_board_id         = local.mondaycom_beneficiary_board_id
  mondaycom_beneficiary_status_column_id = local.mondaycom_beneficiary_status_column_id
  subscription_role_owner_id             = local.subscription_role_owner_id
  aad_tenant_id                          = local.aad_staging_tenant_id
  aad_client_id                          = local.aad_staging_client_id
  aad_client_secret                      = var.aad_staging_client_secret
  aad_extension_app_client_id            = local.aad_staging_extension_app_client_id
  aad_endpoint                           = local.aad_endpoint
  graph_endpoint                         = local.graph_endpoint
  #  domain_name                   = local.domain_name
  #  auth0_target                  = local.auth0_target
}
