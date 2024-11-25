# OpenStack MariaDB Cluster

This repository provides a **basic example** of how to deploy a MariaDB Galera Cluster
in a OpenStack environment with Terraform and Ansible. This example is designed
to demonstrate a minimal setup required and is not intended for production use.

## Usage

* Clone the repository:

```bash
git clone https://github.com/marcvorwerk/openstack-mariadb-cluster.git
cd openstack-mariadb-cluster
```

* Install Dependencies:

```bash
pip install -r requirements.txt
ansible-galaxy collection install -U -r requirements.yaml
```

* Prepare Terraform Infrastructure:

```bash
cd manage-infra
vim variables.tf
```

* Create Infrastructure:

```bash
terraform apply
```

* Bootstrap Cluster:

```bash
cd ../manage-db
ansible-playbook -i openstack.yaml manage.yaml -D
```

## Disclaimer

[!CAUTION]
This example is meant for educational purposes only. For a robust and secure deployment, additional configurations and hardening are necessary.
