########################
# Get PROVIDER Network #
########################

data "openstack_networking_network_v2" "ext01" {
  name = "ext01"
}


###########
# NETWORK #
###########

#variable "cidr" {
#  type = string
#}

resource "openstack_networking_network_v2" "database-network" {
  name = "database-network"
}

resource "openstack_networking_subnet_v2" "database-subnet" {
  name            = "database-subnet"
  network_id      = openstack_networking_network_v2.database-network.id
  ip_version      = 4
  cidr            = "10.0.0.0/24"
  depends_on = [
    openstack_networking_network_v2.database-network
  ]
}


##########
# ROUTER #
##########

resource "openstack_networking_router_v2" "database-router" {
  name                = "database-router"
  admin_state_up      = "true"
  external_network_id = data.openstack_networking_network_v2.ext01.id
  depends_on = [
    openstack_networking_subnet_v2.database-subnet
  ]
}

resource "openstack_networking_router_interface_v2" "add-db-net" {
  router_id  = openstack_networking_router_v2.database-router.id
  subnet_id  = openstack_networking_subnet_v2.database-subnet.id
  depends_on = [
    openstack_networking_router_v2.database-router
  ]
}
