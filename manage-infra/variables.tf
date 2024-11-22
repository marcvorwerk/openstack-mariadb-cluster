#############
# VARIABLES #
#############

variable "bastion_image" {
  type        = string
  default     = "Ubuntu 24.04"
  description = "Operating System for the bastion host"
}

variable "bastion_flavor" {
  type        = string
  default     = "SCS-2V-4-20s"
  description = "Flavor aka size of the bastion host"
}

variable "vm_count" {
  type            = number
  default         = 3
  description     = "Number of Galera servers"
  validation {
    condition     = var.vm_count % 2 == 1
    error_message = "The number of servers must be an odd number in order to build a quorum."
  }
}

variable "image" {
  type        = string
  default     = "Ubuntu 24.04"
  description = "Operating System for the galera hosts"
}

variable "vm_az" {
  type        = string
  default     = "az1"
  description = "Availability Zone"
}

variable "flavor" {
  type        = string
  default     = "SCS-2V-4-20s"
  description = "Flavor aka size of the galera host"
}

variable "key_pair" {
  type        = string
  default     = "playground"
  description = "SSH keypair name in openstack"
}

variable "cloud_init" {
  default = <<EOF
  #cloud-config
  package_update: true
  package_upgrade: true
  packages:
    - docker.io
    - htop
  runcmd:
    - timedatectl set-timezone Europe/Berlin
    - systemctl start docker
    - systemctl enable docker
    - apt-get autoremove -y
    - apt-get clean
EOF
}
