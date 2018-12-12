AWS Security Group
============
This module create DC/OS security groups

The firewall module creates four different policies to be used by provisioning DC/OS Infrastructure

EXAMPLE
-------
```hcl
module "dcos-security-groups" {
  source  = "dcos-terraform/security-groups/aws"
  version = "~> 0.1.0"

  vpc_id = "vpc-12345678"
  cluster_name = "production"
  subnet_range = "172.12.0.0/16"
  admin_ips = ["1.2.3.4/32"]
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin_ips | List of CIDR admin IPs | list | - | yes |
| cluster_name | Name of the DC/OS cluster | string | `aws-example` | no |
| public_agents_additional_ports | List of additional ports allowed for public access on public agents (80 and 443 open by default) | list | `<list>` | no |
| public_agents_ips | List of ips allowed access to public agents. admin_ips are joined to this list | list | `<list>` | no |
| subnet_range | Private IP space to be used in CIDR format | string | - | yes |
| tags | Add custom tags to all resources | map | `<map>` | no |
| vpc_id | AWS VPC ID | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| admin | Firewall rules for debuging access |
| internal | This ELB is internal only |
| master_lb | Firewall rules for master load balancer |
| public_agents | Firewall rules for public agents load balancer |

