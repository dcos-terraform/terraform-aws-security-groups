variable "admin_ips" {
  description = "List of CIDR admin IPs"
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
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "subnet_range" {
  description = "Private IP space to be used in CIDR format"
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

variable "public_agents_additional_ports" {
  description = "List of additional ports allowed for public access on public agents (80 and 443 open by default)"
  type        = "list"
  default     = []
}
