resource "random_id" "key_pair_name" {
  byte_length = 4
  prefix      = "key-${var.env_prefix}-"
}

resource "aws_key_pair" "default" {
  key_name   = random_id.key_pair_name.hex
  public_key = file(var.public_key_path)

  tags = {
    "Name"      = "key-${var.env_prefix}"
    "Creator"   = var.creator
    "Terraform" = true
  }
}