/**
 * AWS Security Group
 * ============
 * This module create DC/OS security groups
 *
 * The firewall module creates four different policies to be used by provisioning DC/OS Infrastructure
 *
 * EXAMPLE
 * -------
 *```hcl
 * module "dcos-security-groups" {
 *   source  = "terraform-dcos/security-groups/aws"
 *   version = "~> 0.1"
 *
 *   vpc_id = "vpc-12345678"
 *   cluster_name = "production"
 *   subnet_range = "172.12.0.0/16"
 *   admin_ips = ["1.2.3.4/32"]
 * }
 *```
 */

provider "aws" {}

resource "aws_security_group" "internal" {
  name        = "dcos-${var.cluster_name}-internal-firewall"
  description = "Allow all internal traffic"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name", var.cluster_name,
                                "Cluster", var.cluster_name))}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.subnet_range}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "master_lb" {
  name        = "dcos-${var.cluster_name}-master-lb-firewall"
  description = "Allow incoming traffic on masters load balancer"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name", var.cluster_name,
                                "Cluster", var.cluster_name))}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ips}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ips}"]
  }
}

resource "aws_security_group" "public_agents" {
  name        = "dcos-${var.cluster_name}-public-agents-lb-firewall"
  description = "Allow incoming traffic on Public Agents load balancer"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name", var.cluster_name,
                                "Cluster", var.cluster_name))}"

  # Do not allow traffic on 22 (SSH) and 5051 (Mesos Agent)
  ingress {
    to_port     = 21
    from_port   = 0
    protocol    = "tcp"
    cidr_blocks = ["${concat(var.admin_ips, var.public_agents_ips)}"]
  }

  ingress {
    to_port     = 5050
    from_port   = 23
    protocol    = "tcp"
    cidr_blocks = ["${concat(var.admin_ips, var.public_agents_ips)}"]
  }

  ingress {
    to_port     = 32000
    from_port   = 5052
    protocol    = "tcp"
    cidr_blocks = ["${concat(var.admin_ips, var.public_agents_ips)}"]
  }

  ingress {
    to_port     = 21
    from_port   = 0
    protocol    = "udp"
    cidr_blocks = ["${concat(var.admin_ips, var.public_agents_ips)}"]
  }

  ingress {
    to_port     = 5050
    from_port   = 23
    protocol    = "udp"
    cidr_blocks = ["${concat(var.admin_ips, var.public_agents_ips)}"]
  }

  ingress {
    to_port     = 32000
    from_port   = 5052
    protocol    = "udp"
    cidr_blocks = ["${concat(var.admin_ips, var.public_agents_ips)}"]
  }
}

resource "aws_security_group" "admin" {
  name        = "dcos-${var.cluster_name}-admin-firewall"
  description = "Allow incoming traffic from admin_ips"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.tags, map("Name", var.cluster_name,
                                "Cluster", var.cluster_name))}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ips}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ips}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ips}"]
  }

  ingress {
    from_port   = 8181
    to_port     = 8181
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ips}"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ips}"]
  }
}
