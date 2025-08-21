# internet-gateway.tf
# Create Internet Gateway for the VPC

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform-created-internet-gateway"
  }
}
