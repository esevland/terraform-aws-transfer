data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["transfer.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "logging_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    ]
    resources = [
      format("arn:aws:logs:%s:%s:*", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
    ]
  }
}
