variable "location" {
  type    = string
  default = "West Europe"
}
variable "environment" {
  type = string
}
variable "subscription_id" {
  type = string
}
variable "backend_access_policy_enabled" {
  type    = bool
  default = true
}
variable "contentful_endpoint" {
  type = string
}
variable "contentful_delivery_token" {
  type = string
}
variable "mondaycom_endpoint" {
  type = string
}
variable "mondaycom_api_token" {
  type = string
}
variable "mondaycom_beneficiary_board_id" {
  type = string
}
variable "mondaycom_beneficiary_ad_id_column_id" {
  type = string
}
variable "mondaycom_beneficiary_status_column_id" {
  type = string
}
variable "subscription_role_owner_id" {
  type = string
}
variable "aad_tenant_id" {
  type = string
}
variable "aad_client_id" {
  type = string
}
variable "aad_client_secret" {
  type = string
}
variable "aad_extension_app_client_id" {
  type = string
}
variable "aad_endpoint" {
  type = string
}
variable "graph_endpoint" {
  type = string
}