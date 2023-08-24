data "http" "outbound_ip" {
  url = "http://ipv4.icanhazip.com"
}

variable "region" {
  description = "The AWS region in which the neo4j instances will be deployed"
}

variable "base_cidr_block" {
  description = "The base CIDR range for the VPC"
}

variable "creator" {
  description = "A variable containing details of the environment's creator"
}

variable "env_prefix" {
  description = "A variable containting a prefix for other variables"
}

variable "qty_k8s_cp_instances" {
  description = "The number of EC2 instances destined to be a k8s control plane instance"
}

variable "qty_k8s_worker_instances" {
  description = "The number of EC2 instances destined to be a k8s worker instance"
}

variable "public_key_path" {
  description = "The location of the SSH key within the local environment"
}

variable "instance_types" {
  description = "A variable containing the desired instance type"
}

locals {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}