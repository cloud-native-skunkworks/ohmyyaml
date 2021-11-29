data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version = "17.24.0"
  cluster_version = "1.21"
  cluster_name    = var.cluster_name
  vpc_id          = data.aws_vpc.default.id
  subnets         = [aws_subnet.main.id, aws_subnet.secondary.id]
  cluster_iam_role_name = "${var.cluster_name}-role"
  manage_cluster_iam_resources = true
  manage_worker_iam_resources  = true
  worker_groups = [
    {
      instance_type = var.instance_type
      asg_max_size  = var.asg_max_size
    }
  ]
  depends_on = [
    aws_subnet.main,
    aws_subnet.secondary
  ]
}
data "aws_vpc" "default" {
  default = true
} 

resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.220.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "secondary" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.221.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "Secondary"
  }
}