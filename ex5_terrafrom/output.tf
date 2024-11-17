# output the floating IP address assigned to VM 1
output "vm1_floating_ip" {
  value = openstack_networking_floatingip_v2.vm1_floating_ip.address
  description = "The floating IP address assigned to VM 1"
}
