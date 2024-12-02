data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu-22.04"
  most_recent = true
}

resource "openstack_compute_instance_v2" "vm" {
  name            = "assignment-vm"
  flavor_name     = "standard.small"
  image_id        = data.openstack_images_image_v2.ubuntu.id
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.web_management.name]

  network {
    name = data.openstack_networking_network_v2.project_network.name
  }

  depends_on = [openstack_networking_secgroup_v2.web_management]
}
