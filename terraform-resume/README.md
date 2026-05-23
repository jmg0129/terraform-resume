# Resume Infrastructure — Terraform

Deploys a static resume site with a visitor counter on AWS.

## Architecture

- **S3** — hosts the static HTML
- **CloudFront** — CDN with HTTPS and custom domain
- **ACM** — SSL/TLS certificate (auto-validated via DNS)
- **Route 53** — DNS pointing jgamm.com → CloudFront
- **API Gateway v2** — HTTP API for the counter endpoint
- **Lambda** — increments the DynamoDB counter
- **DynamoDB** — stores the visitor count

## Prerequisites

- AWS CLI authenticated (`aws login`)
- Terraform installed
- Domain registered and hosted zone in Route 53

## Deployment

```bash
# 1. Initialize Terraform
terraform init

# 2. Preview what will be created
terraform plan

# 3. Deploy everything
terraform apply

# 4. Replace site/index.html with your actual resume, then:
terraform apply
```

## Updating your resume

1. Replace `site/index.html` with your updated file
2. Run `terraform apply`
3. Invalidate the CloudFront cache:
   ```bash
   aws cloudfront create-invalidation \
     --distribution-id $(terraform output -raw cloudfront_distribution_id) \
     --paths "/*"
   ```

## Tear down

```bash
terraform destroy
```

## File structure

```
terraform-resume/
├── providers.tf      # AWS provider config
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── s3.tf             # S3 bucket and policy
├── cloudfront.tf     # CloudFront distribution
├── dns.tf            # Route 53 and ACM certificate
├── apigateway.tf     # API Gateway v2
├── lambda.tf         # Lambda function and IAM
├── dynamodb.tf       # DynamoDB table
├── lambda/
│   └── index.mjs     # Lambda source code
└── site/
    └── index.html    # Resume HTML (replace with yours)
```
