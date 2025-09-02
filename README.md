# AWS Secure Pipeline (Phase 1)

**Goal:** Learn DevSecOps fundamentals by building a security-first pipeline step by step.
This repo will grow from a simple README into:
- Terraform IaC for secure AWS resources
- Automated security scanning in CI (tflint, tfsec, Trivy)
- “Secure by default” patterns (least privilege, encryption, no public access)

## Status
Phase 1: repo scaffolding ✅

## What I’ll add next
Phase 2: Terraform provider skeleton + secure S3 bucket (encryption + block public access)

## Why this project exists
Hiring managers want proof you can ship with guardrails. I’m documenting every step to show understanding—not just copy/paste.

## Phase 2: Secure S3 bucket (complete)
- Enabled default encryption (SSE-S3)
- Blocked all public access (all four switches)
- Bucket policy denies unencrypted PUTs
Next: switch to KMS (CMK) with tight key policy + access logs
