resource "azurerm_subnet" "web_subnet" {
  name                 = "${var.subnet_name}-${local.resource_name_prefix}" #sap-dev
  resource_group_name  = azurerm_resource_group.my_rg.name                  #rg
  virtual_network_name = azurerm_virtual_network.vnet.name                  #vnet
  address_prefixes     = var.subnet_address_prefixes

}