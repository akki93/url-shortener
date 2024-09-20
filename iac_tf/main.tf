module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.vpc.private_subnet[0]
  sg_id = module.vpc.sg_id
}