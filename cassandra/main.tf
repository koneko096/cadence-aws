resource "aws_keyspaces_keyspace" "db" {
  name = "cadence_db"
}

resource "aws_keyspaces_keyspace" "visibility_db" {
  name = "cadence_db_visibility"
}

resource "aws_iam_user_policy" "keyspace_user_policy" {
  name = "${var.username}-policy"
  user = "${var.iam_user}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "ViewOwnUserInfo",
          "Effect": "Allow",
          "Action": [
              "iam:GetUserPolicy",
              "iam:ListGroupsForUser",
              "iam:ListAttachedUserPolicies",
              "iam:ListUserPolicies",
              "iam:GetUser"
          ],
          "Resource": ["arn:aws:iam::*:user/${var.iam_user}"]
      },
      {
          "Sid": "OperateCassandra",
          "Effect":"Allow",
          "Action":[
              "cassandra:*"
          ],
          "Resource":[
              "arn:aws:cassandra:ap-southeast-1:439086027177:/keyspace/*"
          ]
      }
  ]
}
EOF
}