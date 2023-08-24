resource "aws_security_group" "kubernetes_sg" {
  name   = "kubernetes_sg"
  vpc_id = aws_vpc.k8s_env_vpc.id

  ingress {
    description = "SSH access from dev env for ansible"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.outbound_ip.response_body)}/32"]
  }

  ingress {
    description = "https access from dev env to k8s control plane"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.outbound_ip.response_body)}/32"]
  }

  ingress {
    description = "http access from dev env, to connect to k8s service"
    from_port   = 30004
    to_port     = 30005
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.outbound_ip.response_body)}/32"]
  }

  ingress {
    description = "No restrictions on traffic inside the VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.base_cidr_block}"]
  }

  egress {
    description = "No restrictions on outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"      = "kubernetes_sg"
    "Creator"   = var.creator
    "Terraform" = true
  }
}