# HTTP Security Group example

Configuration in this directory creates set of Security Group and Security Group Rules resources in various combination.

Data sources are used to discover existing VPC resources (VPC and default security group).

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.29 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.29 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_http_mysql_1_sg"></a> [http\_mysql\_1\_sg](#module\_http\_mysql\_1\_sg) | ../../modules/http-80 | n/a |
| <a name="module_http_mysql_2_sg"></a> [http\_mysql\_2\_sg](#module\_http\_mysql\_2\_sg) | ../../modules/http-80 | n/a |
| <a name="module_http_sg"></a> [http\_sg](#module\_http\_sg) | ../../modules/http-80 | n/a |
| <a name="module_http_with_egress_minimal_sg"></a> [http\_with\_egress\_minimal\_sg](#module\_http\_with\_egress\_minimal\_sg) | ../../modules/http-80 | n/a |
| <a name="module_http_with_egress_sg"></a> [http\_with\_egress\_sg](#module\_http\_with\_egress\_sg) | ../../modules/http-80 | n/a |
| <a name="module_http_with_ingress_prefix_list_ids_sg"></a> [http\_with\_ingress\_prefix\_list\_ids\_sg](#module\_http\_with\_ingress\_prefix\_list\_ids\_sg) | ../../modules/http-80 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_managed_prefix_list.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the security group |
| <a name="output_security_group_description"></a> [security\_group\_description](#output\_security\_group\_description) | The description of the security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group |
| <a name="output_security_group_owner_id"></a> [security\_group\_owner\_id](#output\_security\_group\_owner\_id) | The owner ID |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | The VPC ID |
<!-- END_TF_DOCS -->
