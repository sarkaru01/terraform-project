resource "azurerm_resource_group" "my_rg" {                 #refrence block and it should be unique
  name     = "${var.rg_name}-${local.resource_name_prefix}" #sap-dev
  location = var.location
  tags     = local.project_tags

}