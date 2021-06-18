output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}

output "ec2_arn" {
  value = aws_instance.instance.arn
}

output "ec2_id" {
  value = aws_instance.instance.id
}
