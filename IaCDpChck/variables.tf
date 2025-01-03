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
  description = "AMI ID to be used (default will be AWS Linux image)"
  type        = string
  default     = "ami-01816d07b1128cd2d"
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
  default     = "deptrack"
}
