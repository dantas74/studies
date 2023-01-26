resource "aws_s3_bucket" "matheus_dr" {
  bucket = "matheus-dr-main-bucket"

  tags = {
    "Name" = "matheus-dr-main-bucket"
  }
}

resource "aws_s3_bucket_acl" "matheus_dr_acl" {
  bucket = aws_s3_bucket.matheus_dr.bucket
  acl    = "private"
}
