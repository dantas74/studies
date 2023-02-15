resource "aws_s3_bucket" "this" {
  bucket = "unique-name-identifier"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "this" {
  for_each = fileset("files/", "*")

  bucket = aws_s3_bucket.this.id
  key    = each.value
  source = each.value

  etag = filemd5(each.value)
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
