variable "admin_ips" {
  description = "List of CIDR ips for admin access"
  type        = "list"
}

variable "public_agents_ips" {
  description = "List of ips allowed access to public agents. admin_ips are joined to this list"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "cluster_name" {
  description = "Name of the DC/OS cluster"
  default     = "aws-example"
}

variable "tags" {
  description = "Custom tags added to the resources created by this module"
  type        = "map"
  default     = {}
}

variable "subnet_range" {
  description = "Private IP space to be used in a CIDR format"
}

variable "vpc_id" {
  description = "VPC ID to create firewall policies in"
}
