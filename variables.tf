variable "aws_region" {
  description = "Region where the instance should be located"
  default = "eu-west-1"
}
variable "instance_type" {
  description = "Instance type to launch"
  default = "t3a.small"
}

variable "ip_whitelist" {
  description = "All allowed ingress IPs"
  default = ["0.0.0.0/32"]
}

variable "email_address" {
  description = "Email to use for the certificate generation"
  default     = ""
}
variable "domain_name" {
  description = "Domain of the Jitsi Server"
  default     = ""
}

variable "zone_id" {
  default = ""
}