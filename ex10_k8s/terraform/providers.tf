# Define required providers
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  user_name   = var.user_name
  tenant_name = var.tenant_name
  password    = var.password
  auth_url    = "https://pouta.csc.fi:5001/v3"
  region      = "regionOne"
}

# Networks
data "openstack_networking_network_v2" "kube_public_network" {
  name = "kube-public"
}

data "openstack_networking_network_v2" "kube_private_network" {
  name = "kube-private"
}

data "openstack_networking_subnet_v2" "kube_public_subnet" {
  name = "project_2011855"
}

data "openstack_networking_subnet_v2" "kube_private_subnet" {
  name = "kube-private-subnet"
}