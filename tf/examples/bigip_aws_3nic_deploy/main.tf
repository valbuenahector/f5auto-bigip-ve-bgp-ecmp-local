provider "aws" {
  region = var.region
}

#
# Create a random id
#
#resource "random_id" "id" {
#  byte_length = 2
#}

#
# Create BIG-IP
#
module "bigip" {
  source                      = "../../"
  count                       = var.instance_count
  prefix                      = format("%s-3nic", var.prefix)
  ec2_key_name                = var.ec2_key_name
  f5_hostname                 = format("%s", var.f5_hostname)
  f5_username                 = var.f5_username
  f5_password                 = var.f5_password
  mgmt_subnet_ids             = var.mgmt_subnet_ids
  mgmt_securitygroup_ids      = var.mgmt_securitygroup_ids
  external_subnet_ids         = var.external_subnet_ids
  external_securitygroup_ids  = var.external_securitygroup_ids
  internal_subnet_ids         = var.internal_subnet_ids
  internal_securitygroup_ids  = var.internal_securitygroup_ids
  external_source_dest_check  = var.external_source_dest_check
  internal_source_dest_check  = var.internal_source_dest_check
}

resource "null_resource" "clusterDO" {
  count = var.instance_count
  provisioner "local-exec" {
    command = "cat > DO_3nic-instance${count.index}.json <<EOL\n ${module.bigip[count.index].onboard_do}\nEOL"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf DO_3nic-instance${count.index}.json"
  }
  depends_on = [module.bigip.onboard_do]
}

#
# Variables used by this example
#
locals {
  allowed_mgmt_cidr = "0.0.0.0/0"
  allowed_app_cidr  = "0.0.0.0/0"
}

resource "null_resource" "ansible_trigger" {
  depends_on = [module.bigip]

  triggers = {
    mgmt_ips = join(",", module.bigip[*].mgmtPublicIP)
  }

  provisioner "local-exec" {
    command = <<EOT
      #Generate outputs in JSON format
      terraform output -json > terraform_output.json

      #Verify the file was created and is not empty
      if [ ! -f terraform_output.json ]; then
        echo "ERROR: terraform_output.json does not exist."
        exit 1
      fi

      if [ ! -s terraform_output.json ]; then
        echo "ERROR: terraform_output.json is empty."
        exit 1
      fi

      #3 Validate JSON structure using 'jq'
      jq empty terraform_output.json
      if [ $? -ne 0 ]; then
        echo "ERROR: terraform_output.json is not valid JSON."
        exit 1
      fi

      #Change directory to Ansible folder
      cd ../../../ansible/playbooks

      #Run your Ansible playbook with the dynamic inventory
      ansible-playbook -i ./dynamic_inventory.py main.yml
    EOT
  }
}
