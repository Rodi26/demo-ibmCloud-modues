provider "ibm" {
}

resource "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}

resource "ibm_is_subnet" "subnet" {
  name                     = var.subnet_name
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = var.location
  total_ipv4_address_count = 256
}

data "ibm_resource_group" "resource_group" {
  name = (var.resource_group != null ? var.resource_group : "default")
}

locals {
  primary_network_interface = [{
    allow_ip_spoofing    = false
    interface_name       = ""
    primary_ipv4_address = ""
    subnet               = ibm_is_subnet.subnet.id
    security_groups      = [ibm_is_vpc.vpc.default_security_group]
    }
  ]
  ssh_keys = tolist(setsubtract(split(",", var.ssh_keys), [""]))
}

module "instance" {
  source = "app.terraform.io/rodolphefontaine-demo/vpc-vsi2/ibm"
  version = "1.0.2"
  name                      = var.name
  vpc_id                    = ibm_is_vpc.vpc.id
  resource_group_id         = data.ibm_resource_group.resource_group.id
  location                  = var.location
  image                     = var.image
  profile                   = var.profile
  ssh_keys                  = local.ssh_keys
  primary_network_interface = local.primary_network_interface
  user_data                 = var.user_data
  network_interfaces        = var.network_interfaces
  volumes                   = var.volumes
  tags                      = var.tags
}