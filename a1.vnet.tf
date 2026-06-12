resource "azurerm_virtual_network" "vnet" {
  name                = "us-vnet1"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  address_space       = ["10.0.0.0/16"]
  tags                = local.project_tags
}