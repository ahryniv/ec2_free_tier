resource "aws_vpc" "vpc" {
  cidr_block  = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags        = local.tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = local.availability_zones[0]
  map_public_ip_on_launch = true

  tags                    = merge(local.tags, {
    Name = "${var.project_slug}-public"
  })
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = local.availability_zones[1]
  map_public_ip_on_launch = true

  tags                    = merge(local.tags, {
    Name = "${var.project_slug}-public2"
  })
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = local.tags
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = local.tags
}

resource "aws_route_table_association" route_table_association {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = concat(aws_route_table.route_table.*.id, [""])[0]
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_slug}-ec2-sg"
  description = "Security group for the EC2 instance"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  tags        = local.tags

  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
  }
  ingress {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
  }
  egress {
    from_port         = "0"
    to_port           = "0"
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    ipv6_cidr_blocks  = ["::/0"]
  }
}
