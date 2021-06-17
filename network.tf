resource "aws_vpc" "vpc" {
  cidr_block  = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags        = local.tags
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = local.availability_zones[0]
  map_public_ip_on_launch = true

  tags                    = merge(local.tags, {
    Name = "${var.project_slug}-public"
  })
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_slug}-ec2-sg"
  description = "Security group for the EC2 instance"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  tags        = local.tags

  ingress {
    from_port         = "22"
    to_port           = "22"
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
