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
  kind                = "Linux"
  reserved            = true

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
    always_on        = true
    app_command_line = "gunicorn --bind=0.0.0.0 --timeout 600 app:app"
    linux_fx_version = "PYTHON|3.6"
    scm_type         = "GitHub"
  }



}