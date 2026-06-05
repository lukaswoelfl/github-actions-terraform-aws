# github-actions-terraform-aws

A CI/CD pipeline to automate the deployment of static websites to AWS S3 using Terraform and GitHub Actions.

## What it does

- **Infrastructure as Code**: Define your AWS S3 bucket with Terraform
- **Automated Deployments**: Push to `main` branch → automatic deployment via GitHub Actions
- **Secure**: Uses GitHub OIDC for AWS authentication (no hardcoded credentials)
- **Static Site Hosting**: Upload HTML, CSS, images directly to S3

## Tech Stack

- **Terraform** — Infrastructure provisioning
- **GitHub Actions** — CI/CD automation
- **AWS S3** — Static site hosting
- **AWS IAM OIDC** — Secure authentication

## Quick Start

1. Set up GitHub Secrets:
   - `IAM_ROLE` — AWS Role ARN for OIDC
   - `AWS_REGION` — AWS region (e.g., `eu-north-1`)
   - `BUCKET_NAME` — S3 bucket name

2. Push to `main` → Workflow runs automatically

## Structure

```
├── terraform/          # Terraform configuration
│   ├── main.tf
│   ├── variables.tf
│   ├── provider.tf
│   └── output.tf
├── personal-website/   # Static site files
│   ├── index.html
│   ├── images/
│   └── styles/
└── .github/workflows/  # GitHub Actions workflow
```

