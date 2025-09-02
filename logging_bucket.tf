# logging_bucket.tf

# 1) The dedicated logs bucket
resource "aws_s3_bucket" "logs" {
  bucket = var.logging_bucket_name
  tags   = var.common_tags
}

# 2) Block all public access
resource "aws_s3_bucket_public_access_block" "logs_pab" {
  bucket                  = aws_s3_bucket.logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 3) Default encryption (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "logs_enc" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 4) Enable lifecycle to expire logs after N days (cost control)
resource "aws_s3_bucket_lifecycle_configuration" "logs_lifecycle" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "expire-access-logs"
    status = "Enabled"

    # REQUIRED in provider v5+: choose one of filter{} or prefix
    filter {}  # empty filter = applies to all objects in the bucket

    expiration {
      days = var.log_retention_days
    }
  }
}

# 5) Ownership controls: server access logging REQUIRES ACLs
#    ObjectWriter allows the S3 Log Delivery group to write objects with their ACL.
resource "aws_s3_bucket_ownership_controls" "logs_ownership" {
  bucket = aws_s3_bucket.logs.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

# 6) Enable ACLs and grant the 'log-delivery-write' canned ACL
#    Note: ACLs must be allowed (step 5) for server access logging to work.
resource "aws_s3_bucket_acl" "logs_acl" {
  bucket = aws_s3_bucket.logs.id
  acl    = "log-delivery-write"

  depends_on = [
    aws_s3_bucket_ownership_controls.logs_ownership
  ]
}
