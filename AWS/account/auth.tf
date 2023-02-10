resource "aws_iam_user" "me" {
  name = "matheus-dr"
}

resource "aws_iam_user_login_profile" "my_login" {
  user                    = aws_iam_user.me.name
  password_length         = 8
  password_reset_required = true
}

resource "aws_iam_access_key" "cli" {
  user = aws_iam_user.me.name
}

resource "aws_iam_user_policy" "admin" {
  policy = "arn:aws:iam::aws:policy/AdministratorAccess"
  user   = aws_iam_user.me.name
}

resource "aws_iam_user_policy" "billing" {
  policy = "arn:aws:iam::aws:policy/Billing"
  user   = aws_iam_user.me.name
}

output "access_key" {
  value = aws_iam_access_key.cli.id
}

output "secret_key" {
  value = aws_iam_access_key.cli.secret
}

output "my_password" {
  value = aws_iam_user_login_profile.my_login.password
}
