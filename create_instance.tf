data "template_file" "install_script" {
  template = file("userdata/install_jitsi.tpl")
  vars = {
    email_address = var.email_address
    domain_name   = var.domain_name
  }
}
resource "aws_instance" "jitsi-meet-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_connections_jitsi-meet.id]
  user_data              = data.template_file.install_script.rendered
  tags = {
    Name = "jitsi-meet-server"
  }
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.jitsi-meet-server.id
  vpc      = true
}

resource "aws_route53_record" "jitsi_record" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "CNAME"
  ttl     = "300"
  records = [aws_eip.elastic_ip.public_dns]
}

resource "aws_security_group" "allow_connections_jitsi-meet" {
  name        = "allow_connections_jitsi-meet"
  description = "Allow TLS inbound traffic for ssh but only for the host PCs external IP."

  ingress {
    from_port   = 10000
    to_port     = 10000
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_connections_jitsi-meet"
  }
}