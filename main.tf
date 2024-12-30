resource "azurerm_resource_group" "pratikshaRG" {
  name     = "pratikshaRG"
  location = local.resource_location
}

resource "azurerm_service_plan" "serviceplan" {
    for_each = var.webapp_environment.production.serviceplan
  name                = each.key
  resource_group_name = azurerm_resource_group.pratikshaRG.name
  location            = local.resource_location
  os_type             = each.value.os_type
  sku_name            = each.value.sku
}
#WebApp
resource "azurerm_windows_web_app" "webapp" {
    for_each = var.webapp_environment.production.serviceapp
  name                = each.key
  resource_group_name = azurerm_resource_group.pratikshaRG.name
  location            = local.resource_location
  service_plan_id     = azurerm_service_plan.serviceplan[each.value].id

  site_config {
    always_on = false
    application_stack {
      current_stack = "dotnet"
      dotnet_version = "v6.0"
    }
  }
}