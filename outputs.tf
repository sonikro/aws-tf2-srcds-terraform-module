output "private_key_pem" {
  sensitive   = true
  value       = tls_private_key.instance_private_key.private_key_pem
  description = "Content of the private key generated for the EC2 Instance, in PEM Format"
}

output "private_key_openssh" {
  sensitive   = true
  value       = tls_private_key.instance_private_key.private_key_openssh
  description = "Content of the private key generated for the EC2 Instance, in Openssh format"
}

output "private_key_path" {
  value       = local.key_path
  description = "Path where the key file was stored"
}
output "instance_public_ip" {
  value       = aws_instance.instance.public_ip
  description = "Public IP address associated with your TF2 Server"
}
