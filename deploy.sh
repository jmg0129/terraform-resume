#!/bin/bash
set -e

# Default landing page (override with: ./deploy.sh bio)
DEFAULT_PAGE="${1:-resume}"

echo "=== Initializing Terraform ==="
terraform init -input=false

echo ""
echo "=== Applying (default_page=${DEFAULT_PAGE}) ==="
terraform apply -var="default_page=${DEFAULT_PAGE}" -auto-approve

echo ""
echo "=== Invalidating CloudFront cache ==="
DIST_ID=$(terraform output -raw cloudfront_distribution_id)
aws cloudfront create-invalidation \
  --distribution-id "$DIST_ID" \
  --paths "/*" \
  --query "Invalidation.Id" \
  --output text

echo ""
echo "=== Done! Site live at https://www.jgamm.com ==="
