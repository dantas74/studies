resource "aws_iam_user" "admin_1" {
  name = "admin-user-1"
}

resource "aws_iam_user" "admin_2" {
  name = "admin-user-2"
}

resource "aws_iam_group" "admin" {
  name = "admin-group"
}

resource "aws_iam_group_membership" "admins" {
  group = aws_iam_group.admin.name
  name  = "admin-users"
  users = [
    aws_iam_user.admin_1.name,
    aws_iam_user.admin_2.name
  ]
}

resource "aws_iam_policy_attachment" "admin_access" {
  groups     = aws_iam_group.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  name       = "admin-users-attachment"
}

resource "aws_iam_role" "matheus_dr_access_role" {
  name               = "s3-matheus-dr-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid: "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "matheus_dr_access_role_policy" {
  name   = "s3-matheus-dr-role-policy"
  role   = aws_iam_role.matheus_dr_access_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.matheus_dr.arn}",
        "${aws_s3_bucket.matheus_dr.arn}/*",
      ]
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "matheus_dr_access_instance_profile" {
  name = "s3-matheus-dr-role"
  role = aws_iam_role.matheus_dr_access_role.name
}
