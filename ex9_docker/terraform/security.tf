resource "openstack_networking_secgroup_v2" "web_management" {
  name        = "web-management"
  description = "Security group for web management interfaces"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = openstack_networking_secgroup_v2.web_management.id
}

resource "openstack_networking_secgroup_rule_v2" "portainer" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9443
  port_range_max    = 9443
  security_group_id = openstack_networking_secgroup_v2.web_management.id
}

resource "openstack_networking_secgroup_rule_v2" "nginx_webui" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 81
  port_range_max    = 81
  security_group_id = openstack_networking_secgroup_v2.web_management.id
}

resource "openstack_networking_secgroup_rule_v2" "http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  security_group_id = openstack_networking_secgroup_v2.web_management.id
}
