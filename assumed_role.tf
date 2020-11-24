data "aws_iam_policy_document" "demo_assumed_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        aws_iam_user.base_user.arn
      ]
    }
    actions = [
      "sts:AssumeRole",
    ]
  }
}

data "aws_iam_policy_document" "demo_assumed_permissions_policy" {
  statement {
    sid = "AssumedPermissions"
    actions = [
      "iam:ListRoles"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]

  }
}

resource "aws_iam_policy" "demo_assumed_policy" {
  name   = "demo_assumed_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.demo_assumed_permissions_policy.json
}

resource "aws_iam_role" "demo_assumed_role" {
  name = "demo_assumed_role"

  assume_role_policy = data.aws_iam_policy_document.demo_assumed_role_policy.json

}

resource "aws_iam_role_policy_attachment" "assumed_permissions_attached" {
  role       = aws_iam_role.demo_assumed_role.name
  policy_arn = aws_iam_policy.demo_assumed_policy.arn
}