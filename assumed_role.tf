data "aws_iam_policy_document" "demo_assumed_role_policy"{
    statement {
        effect = "Allow"
        principals  {
            type =  "AWS"
            identifiers = [
                aws_iam_user.base_user.arn
            ]
        }   
        actions = [
            "sts:AssumeRole",
        ]
    }
}
resource "aws_iam_role" "demo_assumed_role" {
  name = "demo_assumed_role"

  assume_role_policy = data.aws_iam_policy_document.demo_assumed_role_policy.json

}
