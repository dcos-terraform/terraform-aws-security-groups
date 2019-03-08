output "internal" {
  description = "This ELB is internal only"
  value       = "${coalesce(aws_security_group.internal.id, "")}"

  # TODO(mbernadin): remove coalesce when nil on destroy is fixed: https://github.com/hashicorp/terraform/issues/17862
}

output "master_lb" {
  value       = "${aws_security_group.master_lb.id}"
  description = "Firewall rules for master load balancer"
}

output "public_agents" {
  value       = "${aws_security_group.public_agents.id}"
  description = "Firewall rules for public agents load balancer"
}

output "admin" {
  value       = "${aws_security_group.admin.id}"
  description = "Firewall rules for debuging access"
}
