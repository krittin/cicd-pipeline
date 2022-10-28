module "jenkins_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.16.0"

  name = "jenkins_sg"
  vpc_id = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      description = "SSH for admin"
      cidr_blocks = "${var.my_ip}/32"
    },
    {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      description = "Jenkins Web Console"
      cidr_blocks = "${var.my_ip}/32"
    }
  ]
  egress_with_cidr_blocks = [
    {
      description = "Allow all"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

}
