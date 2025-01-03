# Create a Persistent Volume (50GB)
resource "openstack_blockstorage_volume_v3" "load_balancer_volume" {
  name        = "load-balancer-volume"
  size        = 50
  description = "Persistent volume for the Load-Balancer"
}

# Attach the Persistent Volume to the Load-Balancer VM
resource "openstack_compute_volume_attach_v2" "load_balancer_volume_attach" {
  instance_id = openstack_compute_instance_v2.load_balancer.id
  volume_id   = openstack_blockstorage_volume_v3.load_balancer_volume.id
}