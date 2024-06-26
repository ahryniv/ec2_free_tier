output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}

output "ec2_arn" {
  value = aws_instance.instance.arn
}

output "ec2_id" {
  value = aws_instance.instance.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnet_ids" {
  value = [aws_subnet.public_subnet.id, aws_subnet.public_subnet2.id]
}
