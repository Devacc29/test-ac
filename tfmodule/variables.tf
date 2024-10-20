variable "resource_group" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "virtual_networks" {
  description = "The virtal networks with their properties."
  type = map(object({
    name          = string
    address_space = list(string)
  }))
  default = {}
}

variable "subnets" {
  description = "The virtal networks subnets with their properties."
  type = map(object({
    name              = string
    vnet_name         = string
    address_prefixes  = list(string)
    service_endpoints = list(string)
  }))
  default = {}
}


variable "aks_cluster" {
  type = object({
    name               = string
    sku_tier           = string
    dns_prefix         = string
    kubernetes_version = string
  })
}



