variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally-unique name for the secure S3 bucket"
  type        = string
}

variable "common_tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "aws-secure-pipeline"
    Environment = "dev"
    Owner       = "jonathan"
  }
}

variable "kms_key_alias" {
  description = "Alias for the customer-managed KMS key"
  type        = string
  default     = "alias/aws-secure-pipeline"
}
