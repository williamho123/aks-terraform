resource "azurerm_virtual_network" "aks_network" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks_resource_group.name
  address_space       = ["192.168.0.0/20"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.aks_resource_group.name
  address_prefixes     = ["192.168.0.0/24"]
  virtual_network_name = azurerm_virtual_network.aks_network.name
}
