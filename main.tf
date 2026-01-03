module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  eu_availability_zone = var.eu_availability_zone
  cidr_private_subnet  = var.cidr_private_subnet
}

module "security_group" {
  source      = "./security_groups"
  ec2_sg_name = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  ec2_app_sg_name = "SG for EC2 port 8080"
  vpc_id      = module.networking.dev_proj_1_vpc_id
}

module "ec2" {
  source                   = "./ec2"
  ami_id                   = var.ec2_ami_id
  instance_type            = "t3.small"
  tag_name                 = "EC2:Ubuntu Instance"
  public_key               = var.public_key
  subnet_id                = tolist(module.networking.dev_proj_1_public_subnets)[0]
  sg_for_ec2               = [module.security_group.sg_ec2_sg_ssh_http_id, module.security_group.sg_ec2_app_port_8080_8000]
  enable_public_ip_address = true
  user_data_install_ec2    = templatefile("./ec2-runner-script/installer.sh", {})
}

module "lb_target_group" {
  source                   = "./load-balancer-target-group"
  lb_target_group_name     = "ec2-lb-target-group"
  lb_target_group_port     = 80
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.networking.dev_proj_1_vpc_id
  ec2_instance_id          = module.ec2.ec2_instance_id
}

module "alb" {
  source = "./load-balancer"

  lb_name     = "dev-proj-1-alb"
  lb_type     = "application"
  is_external = false

  sg_enable_ssh_https = module.security_group.sg_ec2_sg_ssh_http_id
  subnet_ids          = tolist(module.networking.dev_proj_1_public_subnets)

  tag_name = "dev-proj-1-alb"

  lb_target_group_arn = module.lb_target_group.dev_proj_1_lb_target_group_arn
  ec2_instance_id     = module.ec2.ec2_instance_id

  # HTTP
  lb_listner_port     = 80
  lb_listner_protocol = "HTTP"

  # HTTPS
  lb_https_listner_port     = 443
  lb_https_listner_protocol = "HTTPS"

  # ACM CERT
  dev_proj_1_acm_arn = var.dev_proj_1_acm_arn

  lb_target_group_attachment_port = 80
}
