data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu-20.04"
  most_recent = true
}

# Rancher-Server VM
resource "openstack_compute_instance_v2" "rancher_server" {
  name            = "rancher-server"
  flavor_name     = "standard.medium"
  image_id        = data.openstack_images_image_v2.ubuntu.id
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.security_group_1.name]

  network {
    name = data.openstack_networking_network_v2.kube_public_network.name
  }
}

# Kube-Master VM
resource "openstack_compute_instance_v2" "kube_master" {
  name            = "kube-master"
  flavor_name     = "standard.medium"
  image_id        = data.openstack_images_image_v2.ubuntu.id
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.security_group_2.name]

  network {
    name = data.openstack_networking_network_v2.kube_public_network.name
  }

  network {
    name = data.openstack_networking_network_v2.kube_private_network.name
  }
}

# Kube-Worker-A VM
resource "openstack_compute_instance_v2" "kube_worker_a" {
  name            = "kube-worker-a"
  flavor_name     = "standard.tiny"
  image_id        = data.openstack_images_image_v2.ubuntu.id
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.security_group_2.name]

  network {
    name = data.openstack_networking_network_v2.kube_public_network.name
  }

  network {
    name = data.openstack_networking_network_v2.kube_private_network.name
  }
}

# Load-Balancer VM
resource "openstack_compute_instance_v2" "load_balancer" {
  name            = "load-balancer"
  flavor_name     = "standard.tiny"
  image_id        = data.openstack_images_image_v2.ubuntu.id
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.security_group_1.name]

  network {
    name = data.openstack_networking_network_v2.kube_public_network.name
  }
}
