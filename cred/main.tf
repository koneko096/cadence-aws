locals {
  username          = "aws_keyspace_user"
  cassandra_service = "cassandra.amazonaws.com"
}

# resource "aws_iam_user" "keyspace_user" {
#   name = local.username
# }

resource "aws_iam_service_specific_credential" "keyspace_user_credential" {
  service_name = local.cassandra_service
  user_name    = local.username
}

resource "aws_iam_access_key" "keyspace_user_access_key" {
  user = local.username
}