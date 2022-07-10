# terraform-aws-teamfortress2-server

[![Pipeline](https://github.com/sonikro/terraform-aws-teamfortress2-server/actions/workflows/main.yaml/badge.svg)](https://github.com/sonikro/terraform-aws-teamfortress2-server/actions/workflows/main.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)



> This module was designed to create an Team Fortress 2 Dedicated Server on AWS EC2s.
> 
> It creates the base configuration, but does not add any CFGS/Addons to the server.
> 
> The module outputs variables so you can connect to the server later and finish the setup as you desire.

## System Requirements

To run this module, the system must have **ansible** and **rsync** available in the path.

If you are running this on a CI/CD Pipeline, we recommend using an docker image such as [sonikro/terragrunt-ansible:1.2.4-5.8.0](https://github.com/sonikro/terragrunt-ansible)


## Usage

```hcl
provider "aws" {
    region = "us-east-1"
}

module "sonikro-tf2-server" {
    source = "sonikro/teamfortress2-server/aws"

    vpc_id            = "vpc_id"
    subnet_id         = "subnet_id"
    server_identifier = "unique_identifier"
    rcon_password     = "default_rcon"
    hostname          = "Test @ Sonikro Solutions"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 2.2.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.2.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.2.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.3 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.instance_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.srcds-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.inbound_server_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.inbound_server_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.inbound_ssh_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.inbound_tv_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.inbound_tv_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [local_sensitive_file.private_key](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [null_resource.ansible_playbook](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [tls_private_key.instance_private_key](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/private_key) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/2.2.0/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | If EC2 instance should automatically get an Public IP address | `bool` | `true` | no |
| <a name="input_cpu_credits"></a> [cpu\_credits](#input\_cpu\_credits) | CPU Credits configuration for EC2 Instance | `string` | `"unlimited"` | no |
| <a name="input_default_map"></a> [default\_map](#input\_default\_map) | Default map to the server | `string` | `"cp_process_final"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Map of tags to be applied to all resources | `map(any)` | <pre>{<br>  "Name": "tf2-server"<br>}</pre> | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Default hostname for the server (title that shows in Server Browser) | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Size of EC2 instance to be created | `string` | `"t3.medium"` | no |
| <a name="input_max_players"></a> [max\_players](#input\_max\_players) | Max number of players in the server | `number` | `24` | no |
| <a name="input_rcon_password"></a> [rcon\_password](#input\_rcon\_password) | Default RCON Password for the server | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region to deploy | `string` | `"us-east-1"` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Size in GBs of the root block | `number` | `20` | no |
| <a name="input_server_identifier"></a> [server\_identifier](#input\_server\_identifier) | Unique identifier for this server | `string` | n/a | yes |
| <a name="input_server_port"></a> [server\_port](#input\_server\_port) | SRCDS Server Port | `number` | `27015` | no |
| <a name="input_ssh_port"></a> [ssh\_port](#input\_ssh\_port) | Default SSH Port to connect to the box | `number` | `22222` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet in which the EC2 instance will be created | `string` | n/a | yes |
| <a name="input_tv_port"></a> [tv\_port](#input\_tv\_port) | SourceTV Port | `number` | `27020` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC where your server will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | Public IP address associated with your TF2 Server |
| <a name="output_private_key_openssh"></a> [private\_key\_openssh](#output\_private\_key\_openssh) | Content of the private key generated for the EC2 Instance, in Openssh format |
| <a name="output_private_key_path"></a> [private\_key\_path](#output\_private\_key\_path) | Path where the key file was stored |
| <a name="output_private_key_pem"></a> [private\_key\_pem](#output\_private\_key\_pem) | Content of the private key generated for the EC2 Instance, in PEM Format |
<!-- END_TF_DOCS -->