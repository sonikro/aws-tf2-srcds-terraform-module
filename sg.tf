data "http" "my_public_ip" {
  url = "https://ipv4.icanhazip.com/"
}

resource "aws_security_group" "srcds-sg" {
  vpc_id      = var.vpc_id
  name        = "${var.server_identifier}-srcds"
  description = "Allow SRCDS ports to instance"
  tags        = var.default_tags
}

resource "aws_security_group_rule" "outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.srcds-sg.id
}

resource "aws_security_group_rule" "inbound_ssh_self" {
  type              = "ingress"
  from_port         = var.ssh_port
  to_port           = var.ssh_port
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.my_public_ip.body)}/32"]
  security_group_id = aws_security_group.srcds-sg.id
}

resource "aws_security_group_rule" "inbound_server_tcp" {
  type              = "ingress"
  from_port         = var.server_port
  to_port           = var.server_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.srcds-sg.id
}

resource "aws_security_group_rule" "inbound_server_udp" {
  type              = "ingress"
  from_port         = var.server_port
  to_port           = var.server_port
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.srcds-sg.id
}

resource "aws_security_group_rule" "inbound_tv_tcp" {
  type              = "ingress"
  from_port         = var.tv_port
  to_port           = var.tv_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.srcds-sg.id
}

resource "aws_security_group_rule" "inbound_tv_udp" {
  type              = "ingress"
  from_port         = var.tv_port
  to_port           = var.tv_port
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.srcds-sg.id
}
