resource "aws_cloudwatch_log_group" "cadence_log" {
  name = "cadence-demo-service"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "cadence-log-bucket"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "private"
}