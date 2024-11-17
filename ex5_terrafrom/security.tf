# Security Group 1 for VM 1
resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "security_group_1"
  description = "Security group for VM 1 with SSH and HTTP access"
}

# Allow SSH from anywhere
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_ssh" {
  direction         = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 22
  port_range_max   = 22
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

# Allow HTTP from anywhere
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_http" {
  direction         = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 80
  port_range_max   = 80
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

# Allow all TCP traffic from project network
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_internal" {
  direction         = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 1
  port_range_max   = 65535
  remote_ip_prefix = "192.168.1.0/24"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

# Security Group 2 for VMs 2-4
resource "openstack_networking_secgroup_v2" "secgroup_2" {
  name        = "security_group_2"
  description = "Security group for VMs 2-4 with internal network access only"
}

# Allow all TCP traffic from project network for Security Group 2
resource "openstack_networking_secgroup_rule_v2" "secgroup_2_rule_internal" {
  direction         = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 1
  port_range_max   = 65535
  remote_ip_prefix = "192.168.1.0/24"
  security_group_id = openstack_networking_secgroup_v2.secgroup_2.id
}