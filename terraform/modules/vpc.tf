# Create VPC
resource "aws_vpc" "powerball_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "powerball-vpc"
  }
}

# Create Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.powerball_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "powerball_igw" {
  vpc_id = aws_vpc.powerball_vpc.id

  tags = {
    Name = "powerball-igw"
  }
}

# Create Route Table & Associate with Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.powerball_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.powerball_igw.id
  }

  tags = {
    Name = "powerball-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Create Security Group for ECS & ALB
resource "aws_security_group" "ecs_alb_sg" {
  vpc_id = aws_vpc.powerball_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "powerball-ecs-alb-sg"
  }
}
