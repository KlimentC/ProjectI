output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.myinstanceserver.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.myinstanceserver.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.myinstanceserver.private_ip
}

output "instance_availability_zone" {
  description = "Availability Zone of the EC2 instance"
  value       = aws_instance.myinstanceserver.availability_zone
}

output "instance_security_groups" {
  description = "Security Group IDs attached to the EC2 instance"
  value       = aws_instance.myinstanceserver.vpc_security_group_ids
}




