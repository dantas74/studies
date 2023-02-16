resource "aws_db_subnet_group" "main" {
  name        = "mariadb-subnets"
  description = "Amazon RDS subnets"
  subnet_ids  = [
    aws_subnet.prv_1.id,
    aws_subnet.prv_2.id
  ]
}

resource "aws_db_parameter_group" "mariadb" {
  name        = "mariadb-parameters"
  family      = "mariadb10.4"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "main" {
  allocated_storage       = 20
  engine                  = "mariadb"
  engine_version          = "10.4.8"
  instance_class          = "db.t2.micro"
  storage_type            = "gp2"
  backup_retention_period = 30

  identifier = "mariadb"
  db_name    = "mariadb"
  username   = "root"
  password   = "123change"

  db_subnet_group_name = aws_db_subnet_group.main.name
  parameter_group_name = aws_db_parameter_group.mariadb.name

  multi_az               = false
  vpc_security_group_ids = [aws_security_group.mariadb.id]
  availability_zone      = aws_subnet.prv_1.availability_zone

  skip_final_snapshot = true

  tags = {
    "Name" = "my-mariadb"
  }
}
