#!/usr/bin/env python3

import json
import sys

# Load Terraform JSON output
with open('../../tf/examples/bigip_aws_3nic_deploy/terraform_output.json', 'r') as f:
    terraform_output = json.load(f)

# Extract bigip_instances from the Terraform output
bigip_instances = terraform_output.get("bigip_instances", {}).get("value", [])

# Transform the data into Ansible dynamic inventory format
inventory = {
    "_meta": {
        "hostvars": {}
    },
    "bigip": {
        "hosts": [],
        "vars": {
            "ansible_connection": "local"  # Adjust as needed
        }
    }
}

for instance in bigip_instances:
    # Extract necessary fields
    hostname = instance["hostname"]
    inventory["bigip"]["hosts"].append(hostname)
    inventory["_meta"]["hostvars"][hostname] = {
        "ansible_host": instance["mgmt_private_ip"]["private_ip"][0],
        "mgmt_private_ip": instance["mgmt_private_ip"]["private_ip"][0],
        "internal_private_ip": instance["internal_private_ip"]["private_ip"][0],
        "external_private_ip": instance["external_private_ip"]["private_ip"][0],
        "bigip_user": instance["f5_username"],
        "bigip_password": instance["bigip_password"],
        "mgmt_port": instance["mgmt_port"],
        "hostname": hostname,
    }

# Write the dynamic inventory JSON to stdout
print(json.dumps(inventory, indent=4))
