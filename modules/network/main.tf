resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Web tier public subnets
resource "aws_subnet" "public" {
  count                   = length(var.web_subnet_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.web_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = { 
    Name = "public-${var.azs[count.index]}",
    Tier = "Web"
  }
}

# App tier private subnets
resource "aws_subnet" "app_private" {
  count                   = length(var.app_private_subnet_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.app_private_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false
  tags = { 
    Name = "app-private-${var.azs[count.index]}",
    Tier = "App"
  }
}

# Database tier private subnets
resource "aws_subnet" "db_private" {
  count                   = length(var.db_private_subnet_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.db_private_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false
  tags = { 
    Name = "db-private-${var.azs[count.index]}",
    Tier = "Database"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

# Multiple nAT gateways (one per AZ) for higher availability
resource "aws_eip" "nat" {
  count  = length(var.azs)
  tags = {
    Name = "nat-eip-${var.azs[count.index]}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.azs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "NAT-Gateway-${var.azs[count.index]}"
  }
  depends_on = [aws_internet_gateway.igw]
}

# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-rt"
  }
}

# App tier private route table
resource "aws_route_table" "app_private" {
  count  = length(var.azs)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
  tags = {
    Name = "app-private-rt-${var.azs[count.index]}"
  }
}

# Database tier private route table (no internet access)
resource "aws_route_table" "db_private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "db-private-rt"
  }
}

# Route Table Associations
# Web tier route table association
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# App tier route table associations
resource "aws_route_table_association" "app_private" {
  count          = length(aws_subnet.app_private)
  subnet_id      = aws_subnet.app_private[count.index].id
  route_table_id = aws_route_table.app_private[count.index].id
}

# Database route table
resource "aws_route_table_association" "db_private" {
  count          = length(aws_subnet.db_private)
  subnet_id      = aws_subnet.db_private[count.index].id
  route_table_id = aws_route_table.db_private.id
}