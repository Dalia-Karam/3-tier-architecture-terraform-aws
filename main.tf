module "vpc" {
  source                    = "./modules/vpc"
  vpc_cidr                  = var.vpc_cidr
  azs                       = var.azs
  public_subnets_cidrs      = var.public_subnets_cidrs
  private_app_subnets_cidrs = var.private_app_subnets_cidrs
  private_db_subnets_cidrs  = var.private_db_subnets_cidrs
}

module "security_groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "database" {
  source       = "./modules/rds"
  db_username  = var.username
  db_password  = var.password
  db_name      = "mydb"
  db_subnet_id = module.vpc.private_db_subnet_ids
  rds_sg_ids   = [module.security_groups.rds_sg]
}

module "compute" {
  source = "./modules/compute"
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.vpc.public_subnet_ids
  private_app_subnet_ids = module.vpc.private_app_subnet_ids
  web_sg_ids             = [module.security_groups.web_sg]
  app_sg_ids             = [module.security_groups.app_sg]
  external_alb_sg_ids    = [module.security_groups.external_alb_sg]
  internal_alb_sg_ids    = [module.security_groups.internal_alb_sg]
  key_name               = var.key_name
  web_desired_capacity   = var.web_desired_capacity
  web_min_size           = var.web_min_size
  web_max_size           = var.web_max_size
  app_desired_capacity   = var.app_desired_capacity
  app_min_size           = var.app_min_size
  app_max_size           = var.app_max_size
}


