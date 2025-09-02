locals {
  tags = var.common_tags
}

# EXAMPLE non-KMS resource (inherits default tags automatically)
resource "aws_s3_bucket" "artifacts" {
  bucket = "aws-secure-pipeline-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 3
}

# 1) The bucket itself
resource "aws_s3_bucket" "secure_bucket" {
  bucket = var.bucket_name
  tags   = local.tags
}

# 2) Block all public access flags (defense-in-depth vs. accidental exposure)
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.secure_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 3) Default server-side encryption (SSE-S3). We'll upgrade to KMS in a later step. But now we have set up buckets default encryption to aws:kms with your CMK if cleint doesnt specify encryption headers, S3 uses this default.
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_cmk.arn
    }
  }
}


# 4) Bucket policy to enforce encryption on object PUTs (extra guardrail)
resource "aws_s3_bucket_policy" "deny_unencrypted_puts" {
  bucket = aws_s3_bucket.secure_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Deny any PUT that doesn't request KMS encryption
      {
        Sid       = "DenyNonKMSEncryptedObjectUploads"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:PutObject"
        Resource  = "${aws_s3_bucket.secure_bucket.arn}/*"
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption" = "aws:kms"
          }
        }
      },

      # (Optional but recommended) Deny if they try to use a different KMS key
      {
        Sid       = "DenyWrongKMSKey"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:PutObject"
        Resource  = "${aws_s3_bucket.secure_bucket.arn}/*"
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption-aws-kms-key-id" = aws_kms_key.s3_cmk.arn
          }
        }
      }
    ]
  })
}

