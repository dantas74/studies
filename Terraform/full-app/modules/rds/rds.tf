module "vpc" {
  source = "../vpc"

  environment = var.environment
  aws_region  = var.aws_region
}

resource "aws_db_subnet_group" "this" {
  name        = "${var.environment}-db-sub"
  description = "Allowed subnets for DB instances"
  subnet_ids  = module.vpc.prv_sub_ids

  tags = {
    "Name" = "${var.environment}-db-sub"
  }
}

resource "aws_security_group" "this" {
  name = "${var.environment}-db-sg"

  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
    cidr_blocks = [var.rds_cidr]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }

  tags = {
    "Name" = "${var.environment}-db-sg"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.environment}-rds"
  allocated_storage       = var.allocated_storage
  storage_type            = "gp2"
  engine                  = var.rds_engine
  engine_version          = var.rds_engine_version
  instance_class          = var.db_instance_class
  backup_retention_period = var.backup_retention_period
  publicly_accessible     = var.publicly_accessible
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = [aws_security_group.this.id]
  db_subnet_group_name    = aws_db_subnet_group.this.name
  multi_az                = false
}
