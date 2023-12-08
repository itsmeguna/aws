module "VPC" {
  source              = "terraform-aws-modules/vpc/aws"
  version             = "5.0.0"
  name                = var.VPC
  cidr                = var.VPC_cidr
  azs                 = var.VPC_az
  public_subnets      = var.Public_subnet
  public_subnet_tags  = var.public_subnet_tag
  private_subnets     = var.Private_subnet
  private_subnet_tags = var.private_subnet_tag
  tags                = var.VPC_Tag
  enable_nat_gateway  = true
  single_nat_gateway  = true
}

