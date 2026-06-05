# github-actions-terraform-aws

A CI/CD pipeline to deploy a static website to AWS S3 using Terraform and GitHub Actions.

## What it does

- **Infrastructure as Code**: Creates an S3 bucket with Terraform
- **Automated Deployment**: Runs on `main` push or manual dispatch
- **Secure auth**: Uses AWS IAM role assumption via GitHub Actions
- **Static hosting**: Uploads `index.html`, `images/`, and `styles/` to S3

## GitHub Secrets required

The workflow requires these GitHub Secrets:

- `IAM_ROLE` — AWS Role ARN that GitHub Actions should assume
- `AWS_REGION` — AWS region for Terraform and AWS CLI operations
- `TF_STATE_BUCKET` — Pre-existing S3 bucket where Terraform state is stored
- `TF_BACKEND_KEY` — Path/key for the state file inside the backend bucket
- `WEBSITE_BUCKET_NAME` — Name of the S3 bucket to create for the website

### Notes

- State locking uses S3 with `use_lockfile=true` (no DynamoDB required)
- `encrypt=true` is hardcoded in the workflow
- No AWS access keys stored in the repo; uses GitHub OIDC role assumption

## Workflow behavior

The workflow runs these steps:

1. Checkout the repository
2. Configure AWS credentials by assuming `IAM_ROLE`
3. Install Terraform
4. Initialize Terraform with S3 backend config and state locking
5. Run `terraform plan` with `WEBSITE_BUCKET_NAME` variable
6. Run `terraform apply -auto-approve`
7. Upload `index.html`, `images/`, and `styles/` to the S3 website bucket
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

