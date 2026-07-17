variable "aws_region" {
  description = "AWS Region containing the private S3 origin bucket."
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Lowercase project name used in AWS resource names."
  type        = string
  default     = "iu-secure-static-website"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name may contain only lowercase letters, numbers, and hyphens."
  }
}
