data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.project_slug}-EC2-role"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
  tags = local.tags
}
