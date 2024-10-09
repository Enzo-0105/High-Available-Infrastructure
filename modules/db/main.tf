provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "app-db" {
  allocated_storage = "50"
  engine = "mysql"
  engine_version = "8.0.39"
  instance_class = var.class
  multi_az = false
  storage_type = "gp2"
  availability_zone = "us-east-1a"
  username = var.username
  password = var.password
  
  backup_retention_period = 7
  storage_encrypted = true
  db_subnet_group_name = aws_db_subnet_group.db-sub-grp.name
  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }


}

resource "aws_db_instance" "db-replica" {
  replicate_source_db = aws_db_instance.app-db.identifier
  availability_zone = "us-east-1b"
  instance_class = var.class
  storage_encrypted = true
  auto_minor_version_upgrade  = false

  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }

}


resource "aws_db_subnet_group" "db-sub-grp" {
  name       = "sub-grp"
  subnet_ids = [module.vpc.private1, module.vpc.private2]

  tags = {
    Name = "My DB subnet group"
  }
}


module "vpc" {
  source = "../vpc"
}