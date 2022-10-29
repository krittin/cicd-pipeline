data aws_ami "amazon_linux" {
  most_recent = true
  filter {
    name = "name"
    values = [ var.aws_ami ]
  }
}

resource "aws_key_pair" "jenkins_key" {
  key_name = "cicd_pipeline" 
  public_key = file(var.my_public_key_path)
}

data "template_file" "jenkins_install" {
  template = "${file("${path.module}/scripts/install-jenkins.sh.tpl")}"
  vars = {
    jenkins_admin_password = var.jenkins_admin_password
  }
}

module "jenkins_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.1.4"

  name = "jenkins-server"
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.aws_ec2_instance_type
  key_name = aws_key_pair.jenkins_key.key_name
  associate_public_ip_address = true
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [ module.jenkins_sg.security_group_id ]
  user_data = data.template_file.jenkins_install.rendered
}