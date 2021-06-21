locals {
  availability_zones   = ["${var.region}a", "${var.region}b", "${var.region}c"]
  tags = {
    Environment = var.environment
    Project     = var.project_slug
    Name        = var.project_slug
  }
}

resource "aws_key_pair" "key" {
  key_name    = "${var.project_slug}-${var.environment}"
  public_key  = var.ssh_public_key

  tags        = local.tags
}

resource "aws_instance" "instance" {
  ami                         = var.ec2_ami
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = aws_key_pair.key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  tags                        = local.tags
}
