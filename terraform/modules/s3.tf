resource "aws_s3_bucket" "powerball_models" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket              = aws_s3_bucket.powerball_models.id
  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket" "frontend_bucket" {
  bucket = var.s3_frontend_bucket_name
}

resource "aws_s3_bucket_website_configuration" "frontend_config" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "arn:aws:s3:::${aws_s3_bucket.frontend_bucket.id}/*"
    }]
  })
}
