variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "MyInstanceServer"
}

variable "machine_type" {
  description = "Type of machine to be used"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID to be used (default is AWS Linux image)"
  type        = string
  default     = "ami-0453ec754f44f9a4a"
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
  default     = "deptrack"
}
