resource "tls_private_key" "instance_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "instance_key" {
  key_name   = "${var.server_identifier}-key"
  public_key = tls_private_key.instance_private_key.public_key_openssh

  tags = var.default_tags
}

resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.instance_private_key.private_key_pem
  filename        = local.key_path
  file_permission = "0600"
}
