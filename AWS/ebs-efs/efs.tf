resource "aws_efs_file_system" "this" {
  creation_token   = "this-efs"
  encrypted        = true
  throughput_mode  = "bursting"
  performance_mode = "generalPurpose"
}

resource "aws_efs_backup_policy" "this" {
  file_system_id = aws_efs_file_system.this.id

  backup_policy {
    status = "ENABLED"
  }
}

#resource "aws_efs_file_system_policy" "this" {
#  file_system_id = aws_efs_file_system.this.id
#
#  bypass_policy_lockout_safety_check = true
#
#  policy = templatefile("templates/efs-policy.tftpl", {
#    file_system_arn = aws_efs_file_system.this.arn
#  })
#}

#resource "aws_efs_mount_target" "this" {
#  count           = length(local.availibility_zones)
#  file_system_id  = aws_efs_file_system.this.id
#  subnet_id       = local.pub_subnets[count.index].id
#  security_groups = [aws_security_group.efs_source.id]
#}
