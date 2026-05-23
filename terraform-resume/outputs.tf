output "website_url" {
  description = "Resume website URL"
  value       = "https://${var.domain_name}"
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID (for cache invalidation)"
  value       = aws_cloudfront_distribution.resume.id
}

output "api_endpoint" {
  description = "API Gateway endpoint"
  value       = aws_apigatewayv2_api.counter.api_endpoint
}

output "s3_bucket" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.resume.id
}
