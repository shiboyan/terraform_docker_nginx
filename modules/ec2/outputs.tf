output "id" {
  value = aws_instance.web.id
}

output "ip" {
  value = aws_instance.web.public_ip
}

output "direct" {
  value = aws_instance.web.public_ip
  description = "The public IP address of the main server instance."
}

