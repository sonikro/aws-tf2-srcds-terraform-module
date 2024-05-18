data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "image-id"
    values = [var.ami_id]
  }

  owners = [var.ami_owner]
}

resource "aws_instance" "instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = aws_key_pair.instance_key.key_name
  vpc_security_group_ids      = [aws_security_group.srcds-sg.id]
  subnet_id                   = var.subnet_id
  user_data                   = <<EOF
#!/bin/bash -ex
perl -pi -e 's/^#?Port 22$/Port ${var.ssh_port}/' /etc/ssh/sshd_config
service sshd restart || service ssh restart
EOF

  credit_specification {
    cpu_credits = var.cpu_credits
  }

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]
    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      port        = var.ssh_port
      private_key = file(local.key_path)
    }
  }
  tags = var.default_tags
}

resource "null_resource" "ansible_playbook" {
  depends_on = [
    aws_instance.instance
  ]
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      ANSIBLE_CONFIG            = "${path.module}/ansible.cfg"
    }
    command = <<EOT
ansible-playbook \
    -u ubuntu \
    -i '${aws_instance.instance.public_ip}:${var.ssh_port},' \
    --private-key ${local.key_path} ${path.module}/ansible/setup-tf2-server.yml \
    --extra-vars "hostname='${var.hostname}' rcon_password=${var.rcon_password} max_players=${var.max_players} default_map=${var.default_map} server_port=${var.server_port}"
EOT
  }
}
