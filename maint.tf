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
  name = "Default"
}

data "ibm_is_ssh_key" "ssh_key_id" {
    name = var.ssh_key
}

module "instance" {
  source = "app.terraform.io/rodolphefontaine-demo/vpc-vsi2/ibm"
  version = "1.0.4"
  name                      = var.name
  vpc_id                    = ibm_is_vpc.vpc.id
  resource_group_id         = data.ibm_resource_group.resource_group.id
  location                  = var.location
  image                     = var.image
  profile                   = var.profile
  ssh_keys                  = var.ssh_keys
  user_data                 = var.user_data
  volumes                   = var.volumes
  tags                      = var.tags
}