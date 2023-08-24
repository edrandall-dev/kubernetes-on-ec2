region          = "eu-north-1"
base_cidr_block = "192.168.0.0/16"
creator         = "Ed Randall"

qty_k8s_cp_instances     = 1
qty_k8s_worker_instances = 4

instance_types = {
  "k8s_cp_instance"     = "t3.medium",
  "k8s_worker_instance" = "t3.medium"
}

env_prefix = "k8s-on-ec2"
