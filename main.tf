
terraform {
  required_providers {
    ibm = "~> 1.20"
  }
}



locals {
  BASENAME = "jordax"
  ZONE     = "us-south-1"
}

provider "ibm" {
  region = "us-south"
  generation = 2
  resource_group = "jordax_rg"
}

data "ibm_is_vpc" "vpc" {
  name = "${local.BASENAME}-vpc"
}

data "ibm_is_security_group" "sg1" {
  name = "${local.BASENAME}-sg1"
}


data "ibm_is_subnet" "subnet1" {
  name = "${local.BASENAME}-subnet1"
}

data "ibm_is_image" "ubuntu" {
  name = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}

data "ibm_is_ssh_key" "ssh_key_id" {
  name = "${var.ssh_key_name}"
}




/*

resource "ibm_is_instance" "vsi1" {
  name    = "test"
  vpc     = "r006-77dc4617-c35c-425b-9ac9-a8543637d207"
  zone    = "us-south-1"
  keys    = ["r006-2ffd2fd2-6447-44e0-a9c2-23e1410b44b6"]
  image   = "r006-ed3f775f-ad7e-4e37-ae62-7199b4988b00"
  profile = "cx2-2x4"
  resource_group = "jordax_rg"

  primary_network_interface {
    subnet          = data.ibm_is_subnet.subnet1.id
    security_groups = [data.ibm_is_security_group.sg1.id]
  }
}

resource "ibm_is_floating_ip" "fip1" {
  name   = "${local.BASENAME}-fip1"
  target = ibm_is_instance.vsi1.primary_network_interface[0].id
}



output "ip" {
  value = ibm_is_floating_ip.fip1.address
}
*/

output "sg" {
  value = data.ibm_is_security_group.sg1.id
}

output "subnet" {
  value = data.ibm_is_subnet.subnet1.id
}

output "vpc" {
  value = data.ibm_is_vpc.vpc.id
}

output "image" {
  value = data.ibm_is_image.ubuntu.id
}


output "key" {
  value = data.ibm_is_ssh_key.ssh_key_id.id
}


output "zone" {
  value = local.ZONE
}
