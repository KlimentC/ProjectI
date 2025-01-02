terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh_access"
  description = "Allow SSH access to the EC2 instance"
  tags = {
    Name = "ssh_access"
  }
}

resource "aws_security_group_rule" "ssh_rule" {
  type              = "ingress"
  security_group_id = aws_security_group.ssh_access.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  description       = "Allow SSH access"
}

resource "aws_security_group" "dtrack_access" {
  name        = "dtrack_access"
  description = "Allow access to Dependency-Track ports"
  tags = {
    Name = "dtrack_access"
  }
}

resource "aws_security_group_rule" "dtrack_api_rule" {
  type              = "ingress"
  security_group_id = aws_security_group.dtrack_access.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  description       = "Allow access to Dependency-Track API"
}

resource "aws_security_group_rule" "dtrack_frontend_rule" {
  type              = "ingress"
  security_group_id = aws_security_group.dtrack_access.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  description       = "Allow access to Dependency-Track Frontend"
}

resource "aws_instance" "myinstanceserver" {
  ami                    = var.ami_id
  instance_type          = var.machine_type
  vpc_security_group_ids = [
    aws_security_group.ssh_access.id,
    aws_security_group.dtrack_access.id
  ]
  key_name               = var.key_name

  tags = {
    Name = var.instance_name
  }
}
