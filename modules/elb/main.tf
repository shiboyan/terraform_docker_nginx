# A security group for the ELB so it is accessible via the web
resource "aws_security_group" "elb" {
  name        = "terraform_docker_elb"
  description = "Used in the terraform"
  vpc_id      = var.vpc_output_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "web" {
  name = "terraform-example-elb"

  subnets         = [var.subnet_ids]
  security_groups = [aws_security_group.elb.id]
  instances = [var.ec2_output_id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}