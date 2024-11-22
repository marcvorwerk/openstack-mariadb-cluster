###########
# BASTION #
###########

resource "openstack_compute_instance_v2" "mariadb-bastion" {
  name              = "mariadb-bastion"
  tags              = [
    "env=test",
    "project=tf-mariadb",
    "bastion",
    "jumphost"
  ]
  image_name        = var.bastion_image
  flavor_name       = var.bastion_flavor
  key_pair          = var.key_pair
  availability_zone = var.vm_az
  user_data         = var.cloud_init
  security_groups   = [
    "default",
    openstack_networking_secgroup_v2.database-secgrp.name,
  ]
  network {
    uuid = openstack_networking_network_v2.database-network.id
  }
  depends_on = [
    openstack_networking_subnet_v2.database-subnet
  ]
}

resource "openstack_networking_floatingip_v2" "fip-bastion" {
  pool = "ext01"
  depends_on = [
    openstack_networking_subnet_v2.database-subnet,
    openstack_networking_router_v2.database-router
  ]
}

resource "openstack_compute_floatingip_associate_v2" "fip-assign" {
  floating_ip = "${openstack_networking_floatingip_v2.fip-bastion.address}"
  instance_id = "${openstack_compute_instance_v2.mariadb-bastion.id}"
  depends_on = [
    openstack_compute_instance_v2.mariadb-bastion, 
    openstack_networking_floatingip_v2.fip-bastion
  ]
}


#############
# INSTANCES #
#############

resource "openstack_compute_instance_v2" "tf-instance" {
  count             = var.vm_count
  name              = "mariadb-${count.index}"
  image_name        = var.image
  flavor_name       = var.flavor
  key_pair          = var.key_pair
  availability_zone = var.vm_az
  user_data         = var.cloud_init
  tags              = [
    "env=test",
    "project=tf-mariadb",
    "worker",
    "worker-${count.index}"
  ]
  security_groups   = [
    "default",
    openstack_networking_secgroup_v2.database-secgrp.name,
  ]
  network {
    uuid = openstack_networking_network_v2.database-network.id
  }
  depends_on = [
    openstack_networking_subnet_v2.database-subnet
  ]
}
