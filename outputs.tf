output "bucket_name" {
  description = "The name of the secure bucket"
  value       = aws_s3_bucket.secure_bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the secure bucket"
  value       = aws_s3_bucket.secure_bucket.arn
}


output "kms_key_alias" {
  description = "CMK alias"
  value       = aws_kms_alias.s3_cmk_alias.name
}

output "kms_key_id" {
  value = aws_kms_key.s3_cmk.key_id
}


output "s3_bucket_name" {
  value = aws_s3_bucket.artifacts.bucket
}

