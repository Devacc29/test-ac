output "resource_group_ids" {
  value = azurerm_resource_group.rg.name
}


output "vnet_name" {
  value = [for v in azurerm_virtual_network.vnet : v.name]
}

output "snet_ids" {
  value = { for s in azurerm_subnet.sub : s.name => s.id }
}

output "aks_resource_id" {
  value = azurerm_kubernetes_cluster.aks.id
}