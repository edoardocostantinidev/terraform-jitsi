terraform {
  backend "s3" {
    bucket = "jitsi-terraform-state"
    key    = "jitsi/jitsi.tfstate"
    region = "eu-west-1"
  }
}