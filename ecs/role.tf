resource "aws_iam_role" "cadence_task_demo_role" {
  name = "cadence-task-demo-role"

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "ECSAssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "cadence_task_demo_role_policy" {
  name = "cadence-task-demo-role-policy"
  role = aws_iam_role.cadence_task_demo_role.id

  policy = data.aws_iam_policy_document.cadence_task_demo_role_policy_document.json
}

data "aws_iam_policy_document" "cadence_task_demo_role_policy_document" {
  statement {
    sid    = "ReadSSM"
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:DescribeParameters"
    ]
    resources = [
      var.password_arn
    ]
  }

  statement {
    sid    = "DecryptSecret"
    effect = "Allow"
    actions = [
      "kms:DescribeKey",
      "kms:Decrypt"
    ]
    resources = [
      "arn:aws:kms:${local.region}:${local.account_id}:alias/aws/ssm" // default KMS key
    ]
  }
}