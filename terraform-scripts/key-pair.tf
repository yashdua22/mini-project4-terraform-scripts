# keypair.tf
# Creates an SSH key pair for EC2 instances
# Key name: terraform-created-kp01

resource "aws_key_pair" "terraform_kp" {
  key_name   = "terraform-created-kp01"

  # This generates a new SSH key pair locally
  public_key = tls_private_key.ssh_key.public_key_openssh

  tags = {
    Name = "terraform-created-kp01"
  }
}

# Generate a new private key locally (RSA 4096 bits)
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the private key into a local file
resource "local_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/terraform-created-kp01.pem"
  file_permission = "0600"
}
