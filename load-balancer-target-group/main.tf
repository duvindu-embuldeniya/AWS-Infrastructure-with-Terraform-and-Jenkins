variable "lb_target_group_name" {}
variable "lb_target_group_port" {}
variable "lb_target_group_protocol" {}
variable "vpc_id" {}
variable "ec2_instance_id" {}

output "dev_proj_1_lb_target_group_arn" {
  value = aws_lb_target_group.ec2_lb_target_group.arn
}

# Target group for EC2 instance
resource "aws_lb_target_group" "ec2_lb_target_group" {
  name     = var.lb_target_group_name
  port     = var.lb_target_group_port
  protocol = var.lb_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = "/login"
    port                = 80
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"  # expects HTTP 200
  }
}

# Attach EC2 instance to the target group
resource "aws_lb_target_group_attachment" "ec2_lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.ec2_lb_target_group.arn
  target_id        = var.ec2_instance_id
  port             = 80
}
