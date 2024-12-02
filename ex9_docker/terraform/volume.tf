resource "openstack_blockstorage_volume_v3" "persistent_volume" {
  name        = "docker-volume"
  size        = 5
  description = "Persistent volume for Docker"
}

resource "openstack_compute_volume_attach_v2" "volume_attach" {
  instance_id = openstack_compute_instance_v2.vm.id
  volume_id   = openstack_blockstorage_volume_v3.persistent_volume.id
}
