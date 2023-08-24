resource "aws_iam_role" "k8s_env_role" {
  name               = "${var.env_prefix}_role"
  assume_role_policy = local.assume_role_policy
}

resource "aws_iam_instance_profile" "k8s_env_instance_profile" {
  name = "${var.env_prefix}_profile"
  role = aws_iam_role.k8s_env_role.name
}

resource "aws_iam_role_policy_attachment" "k8s_env_policy_attachment" {
  for_each = toset([
    "AmazonSSMManagedInstanceCore",
    "AmazonEC2FullAccess",
    "IAMFullAccess",
    "AmazonS3FullAccess",
    "AmazonVPCFullAccess"
  ])
  role       = aws_iam_role.k8s_env_role.name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}

