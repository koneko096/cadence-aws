output "iam_user" {
  value = local.username
}

output "username" {
  value = aws_iam_service_specific_credential.keyspace_user_credential.service_user_name
}

output "password" {
  value = aws_iam_service_specific_credential.keyspace_user_credential.service_password  
}