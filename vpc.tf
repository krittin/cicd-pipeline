module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.18.1"

  cidr = var.aws_vpc_cidr_block
  azs = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  public_subnets = [ var.aws_public_subnet_cidr_block ]
  create_igw = true
  enable_dns_hostnames = true
  enable_dns_support = true
}