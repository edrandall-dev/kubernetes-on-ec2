resource "aws_instance" "k8s_cp_instance" {
  ami                    = data.aws_ami.latest_rhel9.id
  instance_type          = var.instance_types["k8s_cp_instance"]
  key_name               = aws_key_pair.default.id
  subnet_id              = aws_subnet.k8s_env_public_subnet.id
  vpc_security_group_ids = ["${aws_security_group.kubernetes_sg.id}"]
  count                  = var.qty_k8s_cp_instances

  iam_instance_profile = aws_iam_instance_profile.k8s_env_instance_profile.name

  user_data = <<EOF
#!/bin/bash
hostname "ctrl-plane-${count.index + 1}"
echo "ctrl-plane-${count.index + 1}" > /etc/hostname
EOF

  tags = {
    "Name"      = "${var.env_prefix}-cp-instance-${count.index + 1}"
    "Creator"   = var.creator
    "Terraform" = true
  }
}

resource "aws_instance" "k8s_worker_instance" {
  ami                    = data.aws_ami.latest_rhel9.id
  instance_type          = var.instance_types["k8s_worker_instance"]
  key_name               = aws_key_pair.default.id
  subnet_id              = aws_subnet.k8s_env_public_subnet.id
  vpc_security_group_ids = ["${aws_security_group.kubernetes_sg.id}"]
  count                  = var.qty_k8s_worker_instances

  iam_instance_profile = aws_iam_instance_profile.k8s_env_instance_profile.name

  user_data = <<EOF
#!/bin/bash
hostname "worker-${count.index + 1}"
echo "worker-${count.index + 1}" > /etc/hostname
EOF

  tags = {
    "Name"      = "${var.env_prefix}-worker-instance-${count.index + 1}"
    "Creator"   = var.creator
    "Terraform" = true
  }
}

