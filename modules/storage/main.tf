resource "azurerm_storage_account" "storage_account" {
  name                     = "fun${var.environment}ucan" # can only contain letters and numbers, length must be between 3-24
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"
}

/* file system container */
resource "azurerm_storage_share" "assets_fs" {
  name                 = "assets"
  storage_account_name = azurerm_storage_account.storage_account.name
  quota                = 50
}


/* blob storage */
resource "azurerm_storage_container" "tmp_container" {
  name                  = "tmp"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "assets_container" {
  name                  = "assets"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}
