# ──────────────────────────────────────────────
# S3 Bucket — Static Resume Site
# ──────────────────────────────────────────────

resource "aws_s3_bucket" "resume" {
  bucket = var.domain_name

  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "resume" {
  bucket = aws_s3_bucket.resume.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "resume" {
  bucket = aws_s3_bucket.resume.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# OAC policy — only CloudFront can read from the bucket
resource "aws_s3_bucket_policy" "resume" {
  bucket = aws_s3_bucket.resume.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontOAC"
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.resume.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.resume.arn
          }
        }
      }
    ]
  })
}

# Upload the resume HTML
resource "aws_s3_object" "resume_html" {
  bucket       = aws_s3_bucket.resume.id
  key          = "index.html"
  source       = "${path.module}/site/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/site/index.html")
}
