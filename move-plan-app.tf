provider "azurerm" {
}
resource "azurerm_resource_group" "rg" {
  name     = "move-plan-rg"
  location = "westus"
}

resource "azurerm_app_service_plan" "svsplan" {
  name                = "alexa-appserviceplan"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "moveplanapp"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.svsplan.id}"
  site_config {
    always_on      = true
    python_version = "3.4"
  }

}