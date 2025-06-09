resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = var.db_subnet_id

  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_db_instance" "primary" {
  allocated_storage      = 10
  engine                 = "mysql"
  identifier             = "mysql-primary"
  engine_version         = "8.0"
  instance_class         = "db.t3.medium"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = var.rds_sg_ids
  multi_az               = true
  publicly_accessible    = false
  tags = {
    Name = "mysql-primary"
  }
}

resource "aws_db_instance" "read_replica" {
  identifier              = "mysql-read-replica"
  replicate_source_db     = aws_db_instance.primary.id
  instance_class          = "db.t3.medium"
  engine                 = aws_db_instance.primary.engine
  engine_version         = aws_db_instance.primary.engine_version
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = var.rds_sg_ids
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags = {
    Name = "mysql-read-replica"
  }
}
