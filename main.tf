locals {
  key_path = format("%s/%s/%s", abspath(path.root), ".ssh", "${var.server_identifier}.pem")
}
