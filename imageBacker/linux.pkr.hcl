packer {
  required_plugins {
     amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.0"
    }
    ansible = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "amazonlinux2023" {
  region               = "us-east-1"
  source_ami           = "ami-0df8c184d5f6ae949"
  instance_type        = "t2.micro"
  ssh_username         = "ec2-user"
  ami_name             = "custom-ami-{{timestamp}}"
  ami_description      = "AMI for UnitTesting"
  tags = {
    "Name" = "UnitTestingAMI"
  }
}

build {
  sources = ["source.amazon-ebs.amazonlinux2023"]

  provisioner "ansible" {
    playbook_file = "../AnsibleConfig/configureawsec.yml"
  }
}
