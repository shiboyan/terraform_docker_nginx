# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "terraform_docker_ec2_security_group"
  description = "Used in the terraform"
  vpc_id      = var.vpc_output_id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
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

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "web" {
  connection {
    user = "ubuntu"
    host = self.public_ip
    private_key = file(var.private_key_path)
  }

  instance_type = "t2.micro"
  ami = lookup(var.aws_amis, var.aws_region)

  key_name = aws_key_pair.auth.id

  vpc_security_group_ids = [
    aws_security_group.default.id]
  subnet_id = var.subnet_id

  # We use this to upload files
  provisioner "file" {
    source = "util/"
    destination = "~"
  }

  provisioner "remote-exec" {
    inline = [
      "sh build.sh",
      "nohup sudo sh monitor.sh > monitor.output 2>&1 &",
      "sudo sh statistics_words_in_home_page.sh",
    ]
  }
}