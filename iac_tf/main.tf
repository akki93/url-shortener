module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.vpc.private_subnet[0]
  sg_id = module.vpc.sg_id
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "api_gw" {
  source = "./modules/api_gw"
  api_gateway_name = "url-shortener-api"
}

module "elasticache" {
  source = "./modules/elasticache"
  redis_instance_type = "cache.t2.micro"
  redis_cluster_id = "url-shortener-redis-cluster"
  redis_subnet_group = "url-shortener-redis-subnet-group"
  redis_subnet_ids = []
}