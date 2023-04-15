# Client web

resource "aws_s3_bucket" "web-client-bucket" {
  bucket        = "${var.APP_NAME}-web-client"
  force_destroy = true

  tags = {
    Name = "${var.APP_NAME}-web-client"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_s3_bucket_website_configuration" "web-client-website" {
  bucket = aws_s3_bucket.web-client-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_acl" "web-client-bucket-acl" {
  bucket = aws_s3_bucket.web-client-bucket.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "web-client-bucket-policy" {
  bucket = aws_s3_bucket.web-client-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = ["${aws_s3_bucket.web-client-bucket.arn}/*"]
      },
    ]
  })
}
