# AWS Secure Pipeline – Terraform Project

This project demonstrates how to build and secure AWS infrastructure using **Terraform**.  
It demonstrates enterprise-grade AWS security patterns and highlights my ability to design, automate, and manage secure cloud environments. A GitHub Actions CI/CD Pipeline automatically runs every push and pull request, executing TFLint for code quality, tfsec for Terraform security misconfiguration scanning, and Teivy for CRITICAL/High vulnerability detection across the repository. Ensuring the infrastructure meets the security standard before any deployment

## Topics: AWS, Terraform, S3, KMS, IaC, Security

---

## 🚀 What This Project Does
- **S3 Bucket**: Provisioned with encryption enabled to secure storage.  
- **KMS Customer Managed Key (CMK)**: Protects sensitive data with key rotation.  
- **IAM Best Practices**: Uses policies and restricted access to enforce least privilege.  
- **Terraform IaC**: Code-driven approach to infrastructure for repeatability and auditability.  

---

## 🛠️ Skills Demonstrated
- **Infrastructure as Code (IaC)** with Terraform  
- **Cloud Security**: IAM, encryption, and access controls  
- **AWS Core Services**: S3, KMS, IAM  
- **Version Control**: Git & GitHub workflows for project tracking  
- **Modular Design**: Using variables, outputs, and a clean folder structure  

---

## 📂 Repo Structure
aws-secure-pipeline/
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ ├── kms.tf
│ ├── providers.tf
│ ├── versions.tf
│ └── .gitignore
| |--README.md
