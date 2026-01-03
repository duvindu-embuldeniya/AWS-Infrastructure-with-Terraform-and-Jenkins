variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "sg_for_ec2" {}
variable "enable_public_ip_address" {}
variable "user_data_install_ec2" {}

output "ec2_instance_id" {
  value = aws_instance.ec2_instance.id
}

# EC2 instance resource
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name               = aws_key_pair.ec2_instance_public_key.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_for_ec2
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_ec2

  metadata_options {
    http_endpoint = "enabled"  # Enable IMDSv2 endpoint
    http_tokens   = "required" # Require IMDSv2 tokens
  }
}

# EC2 key pair
resource "aws_key_pair" "ec2_instance_public_key" {
  key_name   = "id_rsa"
  public_key = var.public_key
}
