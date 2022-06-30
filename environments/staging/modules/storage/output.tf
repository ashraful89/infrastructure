output "connection_string" {
  value = azurerm_storage_account.storage_account.primary_connection_string
}

output "account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "fs_assets_name" {
  value = azurerm_storage_share.assets_fs.name
}

output "primary_access_key" {
  value = azurerm_storage_account.storage_account.primary_access_key
}

output "secondary_access_key" {
  value = azurerm_storage_account.storage_account.secondary_access_key
}
