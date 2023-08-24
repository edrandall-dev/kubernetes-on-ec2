output "control_plane_public_ips" {
  value       = aws_instance.k8s_cp_instance[*].public_ip
  description = "The Public IP for K8s Control Plane Instance(s)"
}

output "worker_public_ips" {
  value       = aws_instance.k8s_worker_instance[*].public_ip
  description = "The Public IP for K8s Worker Instance(s)"
}

output "ctrlplane_private_ip" {
  value       = aws_instance.k8s_cp_instance[*].private_ip
  description = "The Private IP address of the control plane EC2 instance"
}

output "worker_instance_ids" {
  value       = aws_instance.k8s_worker_instance[*].id
  description = "The AWS Instance ID for the K8s Worker Instances(s)"
}

output "ctrl_plane_instance_ids" {
  description = "The AWS Instance ID for the K8s Control Plane  Instances(s)"
  value       = aws_instance.k8s_cp_instance[*].id
}
