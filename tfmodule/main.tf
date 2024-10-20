resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
  tags     = var.tags
}


resource "azurerm_virtual_network" "vnet" {
  for_each            = var.virtual_networks
  name                = each.value["name"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = each.value["address_space"]
  depends_on          = [azurerm_resource_group.rg]
  tags                = var.tags
}


resource "azurerm_subnet" "sub" {
  for_each             = var.subnets
  name                 = each.value["name"]
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = each.value["address_prefixes"]
  service_endpoints    = lookup(each.value, "service_endpoints", null)
  virtual_network_name = each.value["vnet_name"]
  depends_on           = [azurerm_virtual_network.vnet]
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_tier            = var.aks_cluster.sku_tier
  dns_prefix          = var.aks_cluster.dns_prefix
  kubernetes_version  = var.aks_cluster.kubernetes_version
  network_profile {
    network_plugin    = "azure" #azure, kubet, none
    network_policy    = "azure" #calico, azure etc.,,
    load_balancer_sku = "standard"
  }

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "standard_d3"
    vnet_subnet_id = azurerm_subnet.sub["sub1"].id
  }

  identity {
    type = "SystemAssigned"
  }
  tags       = var.tags
}











