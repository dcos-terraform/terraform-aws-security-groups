AWS Security Group
============
This module create DC/OS security groups

The firewall module creates four different policies to be used by provisioning DC/OS Infrastructure

EXAMPLE
-------
```hcl
module "dcos-security-groups" {
  source  = "terraform-dcos/security-groups/aws"
  version = "~> 0.1"

  vpc_id = "vpc-12345678"
  cluster_name = "production"
  subnet_range = "172.12.0.0/16"
  admin_ips = ["1.2.3.4/32"]
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin_ips | List of CIDR ips for admin access | list | - | yes |
| cluster_name | Name of the DC/OS cluster | string | `aws-example` | no |
| public_agents_ips | List of ips allowed access to public agents. admin_ips are joined to this list | list | `<list>` | no |
| subnet_range | Specify the private ip space to be used in a CIDR format | string | - | yes |
| tags | Add special tags to the resources created by this module | map | `<map>` | no |
| vpc_id | The network to create firewall policies in | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| admin | Firewall rules for debuging access |
| internal | Firewall rules for all private interfaces |
| master_lb | Firewall rules for master load balancer |
| public_agents | Firewall rules for public agents load balancer |

