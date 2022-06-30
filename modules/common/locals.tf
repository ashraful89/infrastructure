locals {
  deploy_registry_username = "ucandeploy"
  deploy_registry_url      = "https://ucandeploy.azurecr.io"
  computed_backend_core_app_settings = {
    "AZURE_STORAGE_CONNECTION_STRING" : module.fun_storage.connection_string
  }
}
