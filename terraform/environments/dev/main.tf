module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"
  name = var.cluster_name
  cidr = var.vpc_cidr
  azs = var.azs
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  public_subnet_tags = { "kubernetes.io/role/elb" = 1 }
  private_subnet_tags = { "kubernetes.io/role/internal-elb" = 1 }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
  name = var.cluster_name
  kubernetes_version = "1.33"
  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  addons = { vpc-cni = { before_compute = true, most_recent = true }, eks-pod-identity-agent = { before_compute = true, most_recent = true }, kube-proxy = { most_recent = true }, coredns = { most_recent = true } }
  


  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]
      min_size = 1
      max_size = 2
      desired_size = 1
      
    }
  }
}
