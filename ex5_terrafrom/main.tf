# Data source for Ubuntu image
data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu-22.04"
  most_recent = true
}

# Create VM 1 (the one that will have internet access)
resource "openstack_compute_instance_v2" "vm_1" {
  name            = "vm-1"
  image_id        = data.openstack_images_image_v2.ubuntu.id
  flavor_name     = "standard.small"
  key_pair        = var.key_pair

  network {
    name = data.openstack_networking_network_v2.project_network.name
  }

  security_groups = [openstack_networking_secgroup_v2.secgroup_1.name]
}

# Create VMs 2-4
resource "openstack_compute_instance_v2" "additional_vms" {
  count           = 3
  name            = "vm-${count.index + 2}"
  image_id        = data.openstack_images_image_v2.ubuntu.id
  flavor_name     = "standard.small"
  key_pair        = var.key_pair

  network {
    name = data.openstack_networking_network_v2.project_network.name
  }

  security_groups = [openstack_networking_secgroup_v2.secgroup_2.name]
}