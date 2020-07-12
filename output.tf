output "ELB_DNS_NAME" {
  value = module.elb.dns
}


output "EC2_IP" {
  value = module.ec2.ip
}

output "EC2_LOG_PATH" {
  value = "http://${module.ec2.direct}/log"
}

