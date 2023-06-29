## App Service Plan
resource "azurerm_service_plan" "learnops" {
  name                = var.service_plan_name
  location            = data.azurerm_resource_group.rg-name.location
  resource_group_name = data.azurerm_resource_group.rg-name.name
  sku_name            = "F1"
  os_type             = "Windows"
}

## App WebApp
resource "azurerm_windows_web_app" "learnops" {
  name                = var.web_app_name
  resource_group_name = data.azurerm_resource_group.rg-name.name
  location            = data.azurerm_resource_group.rg-name.location
  service_plan_id     = azurerm_service_plan.learnops.id

  site_config {
    always_on          = false
    auto_heal_enabled  = true
    auto_heal_setting {
      trigger {
        status_code {
          status_code_range = "500"
          interval          = "00:01:00"
          count             = 10
        }
      }
      action {
        action_type                    = "Recycle"
        minimum_process_execution_time = "00:05:00"
      }
    }
    health_check_eviction_time_in_min = 2
    application_stack {
      current_stack                = "dotnet"
      dotnet_version               = "v6.0"
    }
  }
  identity {
    type = "SystemAssigned"
  }
}