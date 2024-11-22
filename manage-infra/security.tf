#######################
### SECURITY GROUPS ###
#######################

# Create database-secgrp
resource "openstack_networking_secgroup_v2" "database-secgrp" {
  name        = "database-secgrp"
  description = "Rules related to the database test setup"
}

# Allow incomming ssh
resource "openstack_networking_secgroup_rule_v2" "database-secgrp_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.database-secgrp.id
  depends_on = [
    openstack_networking_secgroup_v2.database-secgrp
  ]
}

# Allow incomming 3306/tcp aka Standard MariaDB Port
resource "openstack_networking_secgroup_rule_v2" "allow_mariadb_tcp" {
  direction       = "ingress"
  ethertype         = "IPv4"
  protocol        = "tcp"
  port_range_min  = 3306
  port_range_max  = 3306
  remote_ip_prefix = "10.0.0.0/24"
  security_group_id = openstack_networking_secgroup_v2.database-secgrp.id
  depends_on = [
    openstack_networking_secgroup_v2.database-secgrp
  ]
}

# Allow incomming 4567/udp aka Galera Replication Port
resource "openstack_networking_secgroup_rule_v2" "allow_galera_udp" {
  direction       = "ingress"
  ethertype         = "IPv4"
  protocol        = "udp"
  port_range_min  = 4567
  port_range_max  = 4567
  remote_ip_prefix = "10.0.0.0/24"
  security_group_id = openstack_networking_secgroup_v2.database-secgrp.id
  depends_on = [
    openstack_networking_secgroup_v2.database-secgrp
  ]
}

# Allow incomming 4567/tcp aka Galera Replication Port
resource "openstack_networking_secgroup_rule_v2" "allow_galera_tcp" {
  direction       = "ingress"
  ethertype         = "IPv4"
  protocol        = "tcp"
  port_range_min  = 4567
  port_range_max  = 4567
  remote_ip_prefix = "10.0.0.0/24"
  security_group_id = openstack_networking_secgroup_v2.database-secgrp.id
  depends_on = [
    openstack_networking_secgroup_v2.database-secgrp
  ]
}

# Allow incomming 4568/tcp aka IST Port
resource "openstack_networking_secgroup_rule_v2" "allow_ist_tcp" {
  direction       = "ingress"
  ethertype         = "IPv4"
  protocol        = "tcp"
  port_range_min  = 4568
  port_range_max  = 3304568
  remote_ip_prefix = "10.0.0.0/24"
  security_group_id = openstack_networking_secgroup_v2.database-secgrp.id
  depends_on = [
    openstack_networking_secgroup_v2.database-secgrp
  ]
}

# Allow incomming 4444/tcp aka SST Port
resource "openstack_networking_secgroup_rule_v2" "allow_sst_tcp" {
  direction       = "ingress"
  ethertype         = "IPv4"
  protocol        = "tcp"
  port_range_min  = 4444
  port_range_max  = 4444
  remote_ip_prefix = "10.0.0.0/24"
  security_group_id = openstack_networking_secgroup_v2.database-secgrp.id
  depends_on = [
    openstack_networking_secgroup_v2.database-secgrp
  ]
}
