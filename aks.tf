resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks_resource_group.name
  dns_prefix          = "${var.prefix}-aks"

  default_node_pool {
    name               = "default"
    node_count         = 2
    min_count          = 2
    max_count          = 5
    vm_size            = "Standard_D2_v2"
    availability_zones = [1, 2, 3]
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }
}

data "azurerm_public_ip" "example" {
  name                = reverse(split("/", tolist(azurerm_kubernetes_cluster.cluster.network_profile.0.load_balancer_profile.0.effective_outbound_ips)[0]))[0]
  resource_group_name = azurerm_kubernetes_cluster.cluster.node_resource_group
}
