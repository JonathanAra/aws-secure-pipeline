# logging_source.tf
# Enable server access logging on the main bucket.
# Logs will be written *by S3* into the logging bucket using the Log Delivery group.

resource "aws_s3_bucket_logging" "main_to_logs" {
  bucket        = aws_s3_bucket.secure_bucket.id
  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "s3-access-logs/" # organizes log objects under this prefix
}

