# Required without defaults
variable "server_identifier" {
  description = "Unique identifier for this server"
  type        = string
}
variable "vpc_id" {
  description = "The VPC where your server will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet in which the EC2 instance will be created"
  type        = string
}

variable "rcon_password" {
  description = "Default RCON Password for the server"
  type        = string
}

variable "hostname" {
  description = "Default hostname for the server (title that shows in Server Browser)"
  type        = string
}

# Required with defaults

variable "ssh_port" {
  description = "Default SSH Port to connect to the box"
  default     = 22222
}
variable "server_port" {
  description = "SRCDS Server Port"
  default     = 27015
}

variable "tv_port" {
  description = "SourceTV Port"
  default     = 27020
}
variable "max_players" {
  description = "Max number of players in the server"
  default     = 24
}

variable "default_map" {
  description = "Default map to the server"
  default     = "cp_process_final"
}
variable "region" {
  description = "AWS Region to deploy"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Size of EC2 instance to be created"
  type        = string
  default     = "t3.medium"
}

variable "default_tags" {
  type        = map(any)
  description = "Map of tags to be applied to all resources"
  default = {
    Name = "tf2-server"
  }
}

variable "cpu_credits" {
  default     = "unlimited"
  description = "CPU Credits configuration for EC2 Instance"
  type        = string
}

variable "associate_public_ip_address" {
  default     = true
  description = "If EC2 instance should automatically get an Public IP address"
}

variable "root_volume_size" {
  default     = 20
  description = "Size in GBs of the root block"
}

variable "ami_id" {
  default     = "ami-064d3a3177bf5cbda" // Ubuntu 20.04 LTS SA-EAST-1
  description = "AMI ID to be used in the EC2 instance"
}

variable "ami_owner" {
  default     = "679593333241" // Canonical
  description = "Owner of the AMI"
}
