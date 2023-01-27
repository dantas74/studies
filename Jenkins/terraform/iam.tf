resource "aws_iam_user" "this" {
  name = "jenkins-user"
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user_policy" "this" {
  name = "jenkins-s3-access"
  user = aws_iam_user.this.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


output "access_key_id" {
  value = aws_iam_access_key.this.id
}

output "secret_key" {
  value = aws_iam_access_key.this.secret
}
