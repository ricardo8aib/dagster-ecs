# Define the S3 bucket
resource "aws_s3_bucket" "code_location" {
  bucket        = var.BUCKET_NAME
  force_destroy = true
}


# Enable versioning
resource "aws_s3_bucket_versioning" "code_location_versioning" {
  bucket = aws_s3_bucket.code_location.id

  versioning_configuration {
    status = "Enabled"
  }
}

