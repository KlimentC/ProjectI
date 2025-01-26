output "instance_id" {
  value = aws_instance.my_instance.id
}

output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.my_instance.private_ip
}

output "instance_availability_zone" {
  value = aws_instance.my_instance.availability_zone
}

output "instance_security_groups" {
  value = aws_instance.my_instance.vpc_security_group_ids
}
