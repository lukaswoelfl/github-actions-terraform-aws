# github-actions-terraform-aws

A CI/CD pipeline to deploy a static website to AWS S3 using Terraform and GitHub Actions.

## What it does

- **Infrastructure as Code**: Creates an S3 bucket with Terraform
- **Automated Deployment**: Runs on `main` push or manual dispatch
- **Secure auth**: Uses AWS IAM role assumption via GitHub Actions
- **Static hosting**: Uploads `index.html`, `images/`, and `styles/` to S3

## GitHub Secrets required

The workflow currently expects these GitHub Secrets:

- `IAM_ROLE` — AWS Role ARN that GitHub Actions should assume
- `AWS_REGION` — AWS region used for both Terraform and AWS CLI (e.g. `eu-north-1`)
- `BUCKET_NAME` — S3 bucket name for the website and Terraform variable
- `TF_BACKEND_KEY` — Terraform state file key inside the backend bucket
- `TF_BACKEND_DYNAMODB_TABLE` — DynamoDB table name for Terraform state locking

### Notes

- `BUCKET_NAME` is reused for the S3 bucket and Terraform variable `bucket_name`
- `encrypt=true` is hardcoded in the workflow, so no secret is needed for it
- No AWS access keys are stored in the repo because the workflow uses role assumption

## Workflow behavior

The workflow runs these steps:

1. Checkout the repository
2. Configure AWS credentials by assuming `IAM_ROLE`
3. Install Terraform
4. Initialize Terraform with backend config from secrets
5. Run `terraform plan`
6. Run `terraform apply -auto-approve`
7. Upload `index.html`, `images/`, and `styles/` to the target S3 bucket
8. List S3 buckets for validation

## Repository structure

```
├── terraform/                # Terraform configuration
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── output.tf
├── .github/workflows/        # GitHub Actions workflow
│   └── terraform.yaml
├── index.html                # Static website entry point
├── images/                   # Static website assets
└── styles/                   # CSS styles
```

## Publish advice

- Keep backend and state files out of Git (`*.tfbackend`, `*.tfstate`, `.terraform/`, `*.tfvars`)
- Only publicize the repo once no AWS secrets or state files are committed
- The workflow file itself is safe because it only references GitHub Secrets

