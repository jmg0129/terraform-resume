terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Primary region for most resources
provider "aws" {
  region = var.aws_region
}

# us-east-1 provider required for ACM certificates used by CloudFront
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
