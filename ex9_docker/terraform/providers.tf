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
data "openstack_networking_network_v2" "project_network" {
  name = "project_2011855"
}
