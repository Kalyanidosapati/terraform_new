provider "aws" {
  region = "ap-south-1"
}
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example.bucket
  key    = var.object_name
  source = var.source_path
  etag   = filemd5(var.source_path)
}
resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

