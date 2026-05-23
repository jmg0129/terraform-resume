variable "domain_name" {
  description = "Domain name for the resume site"
  type        = string
  default     = "jgamm.com"
}

variable "aws_region" {
  description = "Primary AWS region"
  type        = string
  default     = "us-east-2"
}

variable "default_page" {
  description = "Default landing page: 'resume' or 'bio'"
  type        = string
  default     = "resume"

  validation {
    condition     = contains(["resume", "bio"], var.default_page)
    error_message = "default_page must be 'resume' or 'bio'."
  }
}
