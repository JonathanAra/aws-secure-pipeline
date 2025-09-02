# kms.tf

variable "kms_key_alias_secure" {
  description = "Alias for the customer-managed KMS key"
  type        = string
  default     = "alias/aws-secure-pipeline"
}

resource "aws_kms_key" "s3_cmk" {
  provider                 = aws.notags   # <— IMPORTANT
  description              = "CMK for S3 bucket encryption (aws-secure-pipeline)"
  enable_key_rotation      = true
  deletion_window_in_days  = 7
  # DO NOT include tags here
}

resource "aws_kms_alias" "s3_cmk_alias" {
  provider      = aws.notags              # <— IMPORTANT
  name          = var.kms_key_alias
  target_key_id = aws_kms_key.s3_cmk.key_id
}

