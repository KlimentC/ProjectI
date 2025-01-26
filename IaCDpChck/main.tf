provider "aws" {
  region = "us-east-1"
}

# Security Group for SSH and HTTP/HTTPS/Custom Ports
resource "aws_security_group" "allow_inbound" {
  name        = "allow-inbound"
  description = "Allow inbound SSH (22) and HTTP/HTTPS/Custom Ports (80, 443, 8080, 8081)"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  ami           = var.ami_id
  instance_type = var.machine_type
  subnet_id     = "subnet-0e35581f24e674f72"
  vpc_security_group_ids = [
    aws_security_group.allow_inbound.id
  ]
  key_name      = var.key_name

  tags = {
    Name = var.instance_name
  }

  availability_zone = "us-east-1b"
}

