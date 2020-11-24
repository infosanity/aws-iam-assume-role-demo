data "aws_iam_policy_document" "base_user_policy_statement" {
  statement {
    sid = "AssumeOtherRoles"
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    resources = [
      aws_iam_role.demo_assumed_role.arn
    ]
  }
}

resource "aws_iam_policy" "base_user_policy" {
  name   = "base_user_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.base_user_policy_statement.json
}

resource "aws_iam_user" "base_user" {
  name = "demo-base-user"
  tags = {
    project = var.project
  }
}

resource "aws_iam_user_policy_attachment" "attach_base_user_policy" {
  user       = aws_iam_user.base_user.name
  policy_arn = aws_iam_policy.base_user_policy.arn
}

resource "aws_iam_access_key" "base_user_access_key" {
  user = aws_iam_user.base_user.name
}

output "access_key" {
  value = aws_iam_access_key.base_user_access_key.id
}
output "secret" {
  value = aws_iam_access_key.base_user_access_key.secret
}