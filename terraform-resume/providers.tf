terraform {
  required_version = ">= 1.5"

  backend "s3" {
    bucket         = "jgamm-terraform-state"
    key            = "resume-site/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

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
