output "code_location_bucket_arn" {
  value = {
    code_location_bucket_arn  = aws_s3_bucket.code_location.arn
    code_location_bucket_name = aws_s3_bucket.code_location.name
  }
}
