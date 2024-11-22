##############
### OUTPUT ###
##############

output "Floating-IP" {
  value = openstack_networking_floatingip_v2.fip-bastion.address
}
