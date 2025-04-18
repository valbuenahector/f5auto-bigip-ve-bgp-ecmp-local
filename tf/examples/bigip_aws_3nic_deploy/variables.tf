# Variables for Terraform

variable "f5_hostname" {
  description = "Custom management hostname. Defaults to management public DNS."
  type        = string
  default     = ""
}

variable "ec2_key_name" {
  description = "AWS EC2 Key name for SSH access"
  type        = string
  default     = "tf-demo-key"
}

variable "f5_username" {
  description = "The admin username of the F5 Big-IP that will be deployed"
  default     = "bigipuser"
}

variable "f5_password" {
  description = "Password of the F5 Big-IP that will be deployed"
  default     = ""
}

variable "prefix" {
  description = "Prefix for resources created by this module"
  type        = string
  default     = "hv-bigip"
}

variable "region" {}

variable "cidr" {
  description = "AWS VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availabilityZones" {
  description = "AWS Availability Zones for deployment."
  type        = list(any)
  default     = ["us-west-2b"]
}

variable "AllowedIPs" {}

variable "instance_count" {
  description = "Number of Big-IP instances to create"
  type        = number
  default     = 1
}

variable "mgmt_subnet_ids" {
  description = "Subnets for management interfaces."
  type = list(object({
    subnet_id          = string
    public_ip          = bool
    private_ip_primary = string
  }))
  default = [{ "subnet_id" = null, "public_ip" = null, "private_ip_primary" = null }]
}

variable "external_subnet_ids" {
  description = "Subnets for external interfaces."
  type = list(object({
    subnet_id            = string
    public_ip            = bool
    private_ip_primary   = string
    private_ip_secondary = string
  }))
  default = [{ "subnet_id" = null, "public_ip" = null, "private_ip_primary" = null, "private_ip_secondary" = null }]
}

variable "internal_subnet_ids" {
  description = "Subnets for internal interfaces."
  type = list(object({
    subnet_id          = string
    public_ip          = bool
    private_ip_primary = string
  }))
  default = [{ "subnet_id" = null, "public_ip" = null, "private_ip_primary" = null }]
}

variable "mgmt_securitygroup_ids" {
  description = "Security group IDs for management network."
  type        = list(string)
}

variable "external_securitygroup_ids" {
  description = "Security group IDs for external network."
  type        = list(string)
  default     = []
}

variable "internal_securitygroup_ids" {
  description = "Security group IDs for internal network."
  type        = list(string)
  default     = []
}

variable "internal_source_dest_check" {
  description = "Disable source/dest check on Internal interface to allow inline routing for backends"
  default     = false
}

variable "external_source_dest_check" {
  description = "Disable source/dest check on External interface to allow inline routing for backends"
  default     = false
}