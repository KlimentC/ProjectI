variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "UnitTesting"
}

variable "machine_type" {
  description = "Type of machine to be used"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID from the custom image that is created with packer"
  type        = string
  default     = "ami-0c62f0021c1721996"
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
  default     = "deptrack"
}
