resource "azurerm_resource_group" "aks_resource_group" {
  name     = "${var.prefix}-aks-resources"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks_resource_group.name
  dns_prefix          = "${var.prefix}-aks"

  default_node_pool {
    name                  = "default"
    node_count            = 1
    min_count             = 1
    max_count             = 3
    vm_size               = "Standard_D2_v2"
    availability_zones    = [1, 2, 3]
    enable_auto_scaling   = true
    enable_node_public_ip = true
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }

  addon_profile {
      http_application_routing {
        enabled = true
      }
  }
}
