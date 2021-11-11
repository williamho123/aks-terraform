output "dns_zone" {
  value = azurerm_kubernetes_cluster.cluster.addon_profile.0.http_application_routing.0.http_application_routing_zone_name
}
