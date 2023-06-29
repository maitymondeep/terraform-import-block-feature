module "azure-infra" {
  source = "../../stacks/azure-infra/v0.0.1/"

  resource_group_name = var.resource_group_name
  service_plan_name   = var.service_plan_name
  web_app_name        = var.web_app_name
}

## Import App Service Plan
import {
  to = module.azure-infra.azurerm_service_plan.learnops
  id = "/subscriptions/xxxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx/resourceGroups/rgazwlearnops001/providers/Microsoft.Web/serverfarms/asp-learnops-win-001"
}

## Import Web App
import {
  to = module.azure-infra.azurerm_windows_web_app.learnops
  id = "/subscriptions/xxxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx/resourceGroups/rgazwlearnops001/providers/Microsoft.Web/sites/app-learnops-001"
}