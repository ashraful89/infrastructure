resource "azurerm_monitor_action_group" "developers" {
  name                = "DeveloperAlerts"
  resource_group_name = var.resource_group_name
  short_name          = "DevAlerts"

  arm_role_receiver {
    name                    = "Owner"
    role_id                 = var.subscription_role_owner_id
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_metric_alert" "browser_exceptions" {
  name                = "Browser Exceptions Dynamic ML Alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_insights_id]
  description         = "Browser execptions has had a sharp increase."
  severity            = 1

  dynamic_criteria {
    metric_namespace = "Microsoft.Insights/components"
    metric_name      = "exceptions/browser"
    aggregation      = "Count"
    operator         = "GreaterThan"
    alert_sensitivity = "Medium"
  }

  action {
    action_group_id = azurerm_monitor_action_group.developers.id
  }
}

resource "azurerm_monitor_metric_alert" "browser_exceptions_hard_threshold" {
  name                = "Browser Exceptions Hard Threshold Alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_insights_id]
  description         = "Browser execptions has had a sharp increase."
  severity            = 1

  criteria {
    metric_name      = "exceptions/browser"
    metric_namespace = "Microsoft.Insights/components"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 7
  }

  action {
    action_group_id = azurerm_monitor_action_group.developers.id
  }
}

resource "azurerm_monitor_metric_alert" "dependency_exceptions" {
  name                = "Dependency Exceptions Dynamic ML Alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_insights_id]
  description         = "Dependency Exceptions has had a sharp increase."
  severity            = 1

  dynamic_criteria {
    metric_namespace = "Microsoft.Insights/components"
    metric_name      = "dependencies/failed"
    aggregation      = "Count"
    operator         = "GreaterThan"
    alert_sensitivity = "Medium"
  }

  action {
    action_group_id = azurerm_monitor_action_group.developers.id
  }
}

resource "azurerm_monitor_metric_alert" "failed_requests" {
  name                = "Failed requests Dynamic ML Alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_insights_id]
  description         = "Failed requests has had a sharp increase."
  severity            = 1

  dynamic_criteria {
    metric_namespace = "Microsoft.Insights/components"
    metric_name      = "requests/failed"
    aggregation      = "Count"
    operator         = "GreaterThan"
    alert_sensitivity = "Medium"
  }

  action {
    action_group_id = azurerm_monitor_action_group.developers.id
  }
}

resource "azurerm_monitor_metric_alert" "server_exceptions" {
  name                = "Server Execptions Dynamic ML Alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_insights_id]
  description         = "Server Execptions has had a sharp increase."
  severity            = 1

  dynamic_criteria {
    metric_namespace = "Microsoft.Insights/components"
    metric_name      = "exceptions/server"
    aggregation      = "Count"
    operator         = "GreaterThan"
    alert_sensitivity = "Medium"
  }

  action {
    action_group_id = azurerm_monitor_action_group.developers.id
  }
}

resource "azurerm_monitor_metric_alert" "server_exceptions_hard_threshold" {
  name                = "Server Execptions ML Alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_insights_id]
  description         = "Server Execptions has had a sharp increase."
  severity            = 1

    criteria {
    metric_namespace = "Microsoft.Insights/components"
    metric_name      = "exceptions/server"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 7
  }

  action {
    action_group_id = azurerm_monitor_action_group.developers.id
  }
}

resource "azurerm_monitor_metric_alert" "page_load" {
  name                = "Page Load Time Dynamic ML Alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_insights_id]
  description         = "Page Load Time has had a sharp increase."
  severity            = 2

  dynamic_criteria {
    metric_namespace = "Microsoft.Insights/components"
    metric_name      = "browserTimings/totalDuration"
    aggregation      = "Average"
    operator         = "GreaterThan"
    alert_sensitivity = "Medium"
  }

  action {
    action_group_id = azurerm_monitor_action_group.developers.id
  }
}

resource "azurerm_monitor_metric_alert" "graphql_failures" {
  name                = "GraphQL failures Dynamic ML Alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_insights_id]
  description         = "GraphQL failures has had a sharp increase."
  severity            = 2

  dynamic_criteria {
    metric_namespace = "azure.applicationinsights"
    metric_name      = "GraphQL Failures"
    aggregation      = "Count"
    operator         = "GreaterThan"
    alert_sensitivity = "Medium"
  }

  action {
    action_group_id = azurerm_monitor_action_group.developers.id
  }
}