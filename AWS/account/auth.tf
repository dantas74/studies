resource "aws_iam_user" "cli" {
  name = "matheus-dr-cli"
}

resource "aws_iam_access_key" "cli" {
  user = aws_iam_user.cli.name
}

resource "aws_iam_user_policy" "admin" {
  policy = "arn:aws:iam::aws:policy/AdministratorAccess"
  user   = aws_iam_user.cli.name
}

output "access_key" {
  value = aws_iam_access_key.cli.id
}

output "secret_key" {
  value = aws_iam_access_key.cli.secret
}
