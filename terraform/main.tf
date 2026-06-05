resource "aws_s3_bucket" "static_site" {
  bucket = var.website_bucket_name
}