AWS Security Group
============
This module create DC/OS security groups

The firewall module creates four different policies to be used by provisioning DC/OS Infrastructure

EXAMPLE
-------
```hcl
module "dcos-security-groups" {
  source  = "dcos-terraform/security-groups/aws"
  version = "~> 0.2.0"

  vpc_id = "vpc-12345678"
  cluster_name = "production"
  subnet_range = "172.16.0.0/16"
  admin_ips = ["1.2.3.4/32"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_ips | List of CIDR admin IPs | list | n/a | yes |
| subnet\_range | Private IP space to be used in CIDR format | string | n/a | yes |
| vpc\_id | AWS VPC ID | string | n/a | yes |
| accepted\_internal\_networks | Subnet ranges for all internal networks | list | `<list>` | no |
| adminrouter\_grpc\_proxy\_port |  | string | `"12379"` | no |
| cluster\_name | Name of the DC/OS cluster | string | `"aws-example"` | no |
| open\_admin\_router | Open admin router to public (80+443 on load balancer). WARNING: attackers could take over your cluster | string | `"false"` | no |
| open\_instance\_ssh | Open SSH on instances to public. WARNING: make sure you use a strong SSH key | string | `"false"` | no |
| public\_agents\_access\_ips | List of ips allowed access to public agents. admin_ips are joined to this list | list | `<list>` | no |
| public\_agents\_additional\_ports | List of additional ports allowed for public access on public agents (80 and 443 open by default) | list | `<list>` | no |
| public\_agents\_allow\_dynamic | Allow dynamic / ephemeral ports (49152-65535 see: RFC6335) on public agents public IPs | string | `"false"` | no |
| public\_agents\_allow\_registered | Allow registered / user ports (1024-49151 see: RFC6335) on public agents public IPs | string | `"false"` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin | Firewall rules for debuging access |
| internal | This ELB is internal only |
| master\_lb | Firewall rules for master load balancer |
| public\_agents | Firewall rules for public agents load balancer |

