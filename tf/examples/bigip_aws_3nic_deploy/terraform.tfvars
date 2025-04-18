region                  = "us-west-2"
availabilityZones       = ["us-west-2b"]
AllowedIPs              = ["0.0.0.0/0"]
instance_count          = 0
# ec2_key_name            = "XXXXXXX"
# f5_username             = "XXX"
# f5_password             = "XXXXXX"
prefix                  = "hv"
mgmt_subnet_ids         = [{ "subnet_id" = "subnet-0fd3ce02a3169dba9", "public_ip" = true, "private_ip_primary" = "" }]
external_subnet_ids     = [{ "subnet_id" = "subnet-033e3bdfbb390cc19", "public_ip" = false, "private_ip_primary" = "", "private_ip_secondary" = null }]
internal_subnet_ids     = [{ "subnet_id" = "subnet-099e8c40eb78a2a2e", "public_ip" = false, "private_ip_primary" = "" }]
mgmt_securitygroup_ids  = ["sg-027c2d501a54c219c"]
external_securitygroup_ids = ["sg-0dc34eae5effc290f"]
internal_securitygroup_ids = ["sg-0a937b8830d3ab95a"]