output "bigip_instances" {
  value = [
    for instance in module.bigip : {
      hostname            = instance.mgmtPublicDNS
      mgmt_private_ip     = instance.private_addresses["mgmt_private"]     # Management NIC private IP
      internal_private_ip = instance.private_addresses["internal_private"] # Internal NIC private IP
      external_private_ip = instance.private_addresses["external_private"] # External NIC private IP
      f5_username         = instance.f5_username
      bigip_password      = instance.bigip_password
      mgmt_port           = instance.mgmtPort

      # If your module exports "mgmtPublicIP" as a list of addresses:
      mgmt_public_ip = length(instance.mgmtPublicIP) > 0 ? instance.mgmtPublicIP : null
    }
  ]
}
