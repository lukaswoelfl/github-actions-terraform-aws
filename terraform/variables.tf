variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}

variable "aws_region" {
  description = "AWS region used by the AWS provider"
  type        = string
}