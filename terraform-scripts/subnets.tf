# subnets.tf
# Four subnets: 2 public, 2 private inside terraform-created-vpc01

resource "aws_subnet" "public_sub01" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "172.20.1.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-ip-sub01"
  }
}

resource "aws_subnet" "public_sub02" {
  vpc_id                  = aws_vpc.terraform_vpc.id
  cidr_block              = "172.20.2.0/24"
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-ip-sub02"
  }
}

resource "aws_subnet" "private_sub01" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "172.20.3.0/24"
  availability_zone = "us-west-1a"

  tags = {
    Name = "private-ip-sub01"
  }
}

resource "aws_subnet" "private_sub02" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "172.20.4.0/24"
  availability_zone = "us-west-1c" # corrected "weat" → "west"

  tags = {
    Name = "private-ip-sub02"
  }
}
