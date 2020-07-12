terraform {
  backend "s3" {
    bucket = "terraform-remote-state-mina"
    key    = "terraform-state-docker.tfstate"
    region = "ap-southeast-2"
  }
}
