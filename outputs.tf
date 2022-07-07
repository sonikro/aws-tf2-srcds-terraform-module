output "private_key_pem" {
  sensitive = true
  value     = tls_private_key.instance_private_key.private_key_pem
}

output "private_key_openssh" {
  sensitive = true
  value     = tls_private_key.instance_private_key.private_key_openssh
}

output "private_key_path" {
  value = local.key_path
}
output "instance_public_ip" {
  value = aws_instance.instance.public_ip
}
