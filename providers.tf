# Default provider (with default tags for all NON-KMS resources)
provider "aws" {
  region = var.aws_region

  # Apply tags everywhere by default (except where we use the no-tags alias)
  default_tags {
    tags = local.tags
  }
}

# Alias provider with **no** default tags — use ONLY for KMS resources
provider "aws" {
  alias  = "notags"
  region = var.aws_region
}

