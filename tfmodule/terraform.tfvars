resource_group = "test-rg-aceo-01"
location       = "eastus2"
tags = {
  env        = "test"
  created_by = "1234@gmail.com"
}

virtual_networks = {
  vnet = {
    name          = "test-rg-vnet-01"
    address_space = ["10.10.24.0/21"]
  }
}

subnets = {
  sub1 = {
    name              = "test-vnet-01-sub1"
    vnet_name         = "test-rg-vnet-01"
    address_prefixes  = ["10.10.28.0/22"]
    service_endpoints = ["Microsoft.Keyvault"]
  }
}


aks_cluster = {
  name               = "aks-aceo-30"
  sku_tier           = "Free"
  dns_prefix         = "aks-aceo-30"
  kubernetes_version = "1.30.0"
}