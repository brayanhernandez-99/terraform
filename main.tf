# Provider 
provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "vpc_example" {
  cidr_block = "192.168.0.0/16"

  tags {
    Name = "vpc_example"
  }
}

# Subnet 1: 192.168.1.0/24
resource "aws_subnet" "snet_backend" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "us-east-1a"

  tags {
    Name = "snet_backend"
  }
}

# Subnet 2: 192.168.2.0/24
resource "aws_subnet" "snet_frontend" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "us-east-1b"

  tags {
    Name = "snet_frontend"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw_example" {
  vpc_id = aws_vpc.vpc_example.id

  tags {
    Name = "igw_example"
  }
}

# Route Table
resource "aws_route_table" "rt_example" {
  vpc_id = aws_vpc.vpc_example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_example.id
  }

  tags {
    Name = "rt_example"
  }
}

# Route Table Association Backend
resource "aws_route_table_association" "rta_backend" {
  subnet_id      = aws_subnet.snet_backend.id
  route_table_id = aws_route_table.tb_example.id
}

# Route Table Association Frontend
resource "aws_route_table_association" "rta_frontend" {
  subnet_id      = aws_subnet.snet_backend.id
  route_table_id = aws_route_table.tb_example.id
}

# Security Group
resource "aws_security_group" "sg_example" {
  name        = "sg_example"
  description = "Allow SSH"
  vpc_id      = aws_vpc.vpc_example.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "sg_example"
  }
}

# EC2 Instance
resource "aws_instance" "ec2_backend" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.snet_backend.id
  vpc_security_group_ids = ["${aws_security_group.sg_example.id}"]

  tags {
    Name = "ec2_backend"
  }
}

# EC2 Instance
resource "aws_instance" "ec2_frontend" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.snet_frontend.id
  vpc_security_group_ids = ["${aws_security_group.sg_example.id}"]

  tags {
    Name = "ec2_frontend"
  }
}

