variable "my_ip" {
  type = string
}

variable "provider_profile" {
  type = string
  description = "AWS profile set up for AWS CLI"
}

variable "aws_region" {
  type = string
  default = "eu-west-2"
}

variable "aws_vpc_cidr_block" {
  type = string
  default = "172.1.0.0/16"
}

variable "aws_public_subnet_cidr_block" {
  type = string
  default = "172.1.1.0/24"
}

variable "aws_ec2_instance_type" {
  type = string
  default = "t3.micro"
}

variable "my_public_key_path" {
  type = string
}

variable "aws_ami" {
  type = string
  default = "amzn2-ami*"
}