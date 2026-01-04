variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "ec2_app_sg_name" {}  


output "sg_ec2_sg_ssh_http_id" {
  value = aws_security_group.ec2_sg_ssh_http_https.id
}

output "sg_ec2_app_port_8080_8000" {
  value = aws_security_group.ec2_sg_8080_8000.id
}

# Security Group for SSH, HTTP, HTTPS
resource "aws_security_group" "ec2_sg_ssh_http_https" {
  name        = var.ec2_sg_name
  description = "Enable SSH(22), HTTP(80) & HTTPS(443)"
  vpc_id      = var.vpc_id

  # SSH access
  ingress {
    description = "Allow SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # HTTP access
  ingress {
    description = "Allow HTTP from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # HTTPS access
  ingress {
    description = "Allow HTTPS from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  # Outbound traffic
  egress {
    description = "Allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group: SSH(22), HTTP(80), HTTPS(443)"
  }
}

# Security Group for app traffic on port 8080 & 8000 (gunicorn)
resource "aws_security_group" "ec2_sg_8080_8000" {
  name        = var.ec2_app_sg_name
  description = "Enable port 8080 and 8000 for app access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow access to port 8080"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }

  ingress {
    description = "Allow access to port 8000"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
  }

  tags = {
    Name = "Security Group: Ports 8080 & 8000"
  }
}

