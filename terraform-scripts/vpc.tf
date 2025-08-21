# vpc.tf
# Creating a VPC with CIDR block 172.20.0.0/16

resource "aws_vpc" "terraform_vpc" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-created-vpc01"
  }
}
