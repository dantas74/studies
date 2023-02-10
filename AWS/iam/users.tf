resource "aws_iam_user" "other" {
  name = "other-user"
}

resource "aws_iam_user_login_profile" "other_login" {
  user                    = aws_iam_user.other.name
  password_length         = 8
  password_reset_required = true
}

resource "aws_iam_user_policy_attachment" "other_permissions" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  user       = aws_iam_user.other.name
}

output "other_login" {
  value = aws_iam_user_login_profile.other_login.password
}
