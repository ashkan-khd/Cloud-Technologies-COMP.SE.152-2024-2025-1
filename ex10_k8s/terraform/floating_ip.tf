# Get external network data
data "openstack_networking_network_v2" "external_network" {
  name = "public"
}

# Create Floating IP for Rancher-Server
resource "openstack_networking_floatingip_v2" "rancher_server_floating_ip" {
  pool = data.openstack_networking_network_v2.external_network.name
}

# Associate Floating IP with Rancher-Server
resource "openstack_compute_floatingip_associate_v2" "rancher_server_floating_ip_association" {
  floating_ip = openstack_networking_floatingip_v2.rancher_server_floating_ip.address
  instance_id = openstack_compute_instance_v2.rancher_server.id
}

# Create Floating IP for Load-Balancer
resource "openstack_networking_floatingip_v2" "load_balancer_floating_ip" {
  pool = data.openstack_networking_network_v2.external_network.name
}

# Associate Floating IP with Load-Balancer
resource "openstack_compute_floatingip_associate_v2" "load_balancer_floating_ip_association" {
  floating_ip = openstack_networking_floatingip_v2.load_balancer_floating_ip.address
  instance_id = openstack_compute_instance_v2.load_balancer.id
}
