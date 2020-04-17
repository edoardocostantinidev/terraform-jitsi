output "route_53_record" {
  value = aws_route53_record.jitsi_record.name
}