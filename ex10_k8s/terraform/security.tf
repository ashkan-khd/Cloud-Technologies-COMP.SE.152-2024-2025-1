# Security Group 1
resource "openstack_networking_secgroup_v2" "security_group_1" {
  name        = "security_group_1"
  description = "Allow SSH, HTTP, HTTPS, and all TCP traffic from kube-public"
}

resource "openstack_networking_secgroup_rule_v2" "sg1_ssh" {
  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 22
  port_range_max   = 22
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group_1.id
}

resource "openstack_networking_secgroup_rule_v2" "sg1_http" {
  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 80
  port_range_max   = 80
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group_1.id
}

resource "openstack_networking_secgroup_rule_v2" "sg1_https" {
  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 443
  port_range_max   = 443
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group_1.id
}

resource "openstack_networking_secgroup_rule_v2" "sg1_kube_public" {
  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  remote_ip_prefix = data.openstack_networking_subnet_v2.kube_public_subnet.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group_1.id
}

# Security Group 2
resource "openstack_networking_secgroup_v2" "security_group_2" {
  name        = "security_group_2"
  description = "Allow all TCP and UDP traffic from kube-public and kube-private"
}

resource "openstack_networking_secgroup_rule_v2" "sg2_kube_public_tcp" {
  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  remote_ip_prefix = data.openstack_networking_subnet_v2.kube_public_subnet.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group_2.id
}

resource "openstack_networking_secgroup_rule_v2" "sg2_kube_public_udp" {
  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "udp"
  remote_ip_prefix = data.openstack_networking_subnet_v2.kube_public_subnet.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group_2.id
}

resource "openstack_networking_secgroup_rule_v2" "sg2_kube_private_tcp" {
  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  remote_ip_prefix = data.openstack_networking_subnet_v2.kube_private_subnet.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group_2.id
}

resource "openstack_networking_secgroup_rule_v2" "sg2_kube_private_udp" {
  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "udp"
  remote_ip_prefix = data.openstack_networking_subnet_v2.kube_private_subnet.cidr
  security_group_id = openstack_networking_secgroup_v2.security_group_2.id
}
