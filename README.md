# F5 BIG-IP VE Auto-Scaler on AWS with Terraform & Ansible

This project automates the deployment and configuration of scalable F5 BIG-IP VE instances in AWS using [Terraform](https://www.terraform.io/) and [Ansible](https://www.ansible.com/). It leverages a Python-based dynamic inventory to bridge Terraform outputs with Ansible playbooks for seamless orchestration.

---

## Features

- **Automated AWS Infrastructure**: Deploys VPCs, subnets, security groups, and EC2 instances for BIG-IP VE using Terraform.
- **Multi-NIC & Multi-Instance Support**: Easily scale out deployments with configurable instance count and network interfaces.
- **Dynamic Inventory**: Uses a Python script to generate Ansible inventory from Terraform outputs.
- **Automated BIG-IP Configuration**: Ansible playbooks configure BIG-IP modules, networking, SNMP, pools, nodes, and more.
- **Modular & Extensible**: Easily adapt for different topologies (1-NIC, 3-NIC, etc.) and environments.

---

## Directory Structure

```
.vscode/                # VSCode settings
ansible/                # Ansible configuration and playbooks
  ansible.cfg
  playbooks/
    base.yml
    main.yml
    routing.yml
    var.yml
    dynamic_inventory.py
tf/                     # Terraform modules, configs, and examples
  main.tf
  variables.tf
  outputs.tf
  examples/
    bigip_aws_3nic_deploy/
      terraform.tfvars
      ...
```

---

## Prerequisites

- [Terraform](https://www.terraform.io/) >= 0.13 (tested with v1.1.8)
- [Ansible](https://www.ansible.com/) >= 2.9
- Python 3.x (for dynamic inventory)
- AWS credentials with permissions to create VPC, EC2, IAM, etc.
- F5 BIG-IP VE license (BYOL or PAYG)

---

## Quick Start

### 1. Configure Terraform Variables

Edit [`terraform.tfvars`](tf/examples/bigip_aws_3nic_deploy/terraform.tfvars) to set your AWS region, subnets, security groups, instance count, and credentials.

### 2. Deploy Infrastructure

```sh
cd tf/examples/bigip_aws_3nic_deploy
terraform init
terraform apply
```

This will provision the AWS infrastructure and output a `terraform_output.json` file.

### 3. Run Ansible Playbooks

The dynamic inventory script [`dynamic_inventory.py`](ansible/playbooks/dynamic_inventory.py) reads the Terraform output and generates inventory for Ansible.

```sh
cd ../../../ansible/playbooks
ansible-playbook -i ./dynamic_inventory.py main.yml
```

Or use the integrated workflow defined in the Terraform `main.tf` [example](tf/examples/bigip_aws_3nic_deploy/main.tf).

---

## How It Works

- **Terraform** provisions AWS resources and outputs instance/network details as JSON.
- **Dynamic Inventory**: [`dynamic_inventory.py`](ansible/playbooks/dynamic_inventory.py) parses the Terraform output and creates an inventory for Ansible.
- **Ansible**: Playbooks like [`base.yml`](ansible/playbooks/base.yml) configure BIG-IP devices (networking, SNMP, pools, nodes, etc.) using the dynamic inventory.

---

## Customization

- Adjust instance count, subnets, and other parameters in [`terraform.tfvars`](tf/examples/bigip_aws_3nic_deploy/terraform.tfvars).
- Modify Ansible playbooks in [`ansible/playbooks/`](ansible/playbooks/) to customize BIG-IP configuration.
- Add or update templates and onboarding JSON in [`tf/config/`](tf/config/).

---

## References

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [F5 BIG-IP Ansible Modules](https://clouddocs.f5.com/products/orchestration/ansible/devel/)
- [F5 BIG-IP VE Documentation](https://support.f5.com/csp/knowledge-center/software/BIG-IP-VE)

---

## License

See [`tf/LICENSE`](tf/LICENSE).

---

## Support

This project is community-supported. For F5 product support, see [F5 Support](https://support.f5.com/).
