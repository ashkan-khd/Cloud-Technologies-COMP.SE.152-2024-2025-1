# Get external network data
data "openstack_networking_network_v2" "external_network" {
  name = "public"
}

# Create floating IP
resource "openstack_networking_floatingip_v2" "vm1_floating_ip" {
  pool = data.openstack_networking_network_v2.external_network.name
}

# Associate floating IP with VM 1
resource "openstack_compute_floatingip_associate_v2" "vm1_floating_ip_association" {
  floating_ip = openstack_networking_floatingip_v2.vm1_floating_ip.address
  instance_id = openstack_compute_instance_v2.vm_1.id
}
