# rds.tf
# MySQL RDS instance with Free Tier eligible settings

# Security group for RDS (only My IP on port 3306)
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg01"
  description = "Allow MySQL access from my IP"
  vpc_id      = aws_vpc.terraform_vpc.id

  ingress {
    description = "MySQL from my IP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg01"
  }
}

# Subnet group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.public_sub01.id, aws_subnet.public_sub02.id]

  tags = {
    Name = "rds-subnet-group"
  }
}

# RDS MySQL instance
resource "aws_db_instance" "rds_mysql" {
  identifier              = "accounts"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"          # latest MySQL version
  instance_class          = "db.t3.micro"  # free tier eligible
  username                = "admin"
  password                = "yash@123"
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  publicly_accessible     = false
  multi_az                = false

  tags = {
    Name = "accounts"
  }
}
