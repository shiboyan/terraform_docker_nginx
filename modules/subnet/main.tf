# Create a subnet to launch our instances into
resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_output_id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = true
}