resource "azurerm_network_security_group" "example" {
  name                = "${var.subnet_name}-${local.resource_name_prefix}-nsg"
  location            = azurerm_resource_group.my_rg.location
  resource_group_name = azurerm_resource_group.my_rg.name
  tags                = local.project_tags
}
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.example.id

}

locals {
  web_nsg_rule = {  #web_nsg_rule is your name 
    "110" : "22", #key value pair 110 is priority and 22 is port number
    "120" : "80",
    "130" : "443"
  }
}

resource "azurerm_network_security_rule" "Web_nsg_rule" {
  #how to use this name express inside the resource block 
  for_each                    = local.web_nsg_rule         #it will iterate 3 times because we have 3 key value pair in the map
  name                        = "Allow-Port-${each.value}" #allow-port-22 
  priority                    = each.key                   #110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"        #can we open 80 and 443 22 30000-32000
  destination_port_range      = each.value #22
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg.name
  network_security_group_name = azurerm_network_security_group.example.name
}