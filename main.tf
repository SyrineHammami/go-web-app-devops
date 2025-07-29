# main.tf
# this is just a dummy for now 
# Put here your desired AWS region
provider "aws" {
  region = "eu-central-1" 
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.21"

  vpc_config {
    subnet_ids = ["subnet-12345678", "subnet-87654321"] # Specify your subnet IDs
  }
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = "my-keypair"
  }
}

resource "aws_launch_template" "my_launch_template" {
  name_prefix = "my-launch-template"
  image_id    = "ami-12345678" # Specify your desired AMI ID
  instance_type = "t3.medium"  # Specify your desired instance type
  key_name    = "my-keypair"   # Specify your SSH keypair
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "eks.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  })
}

resource "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.my_cluster.name

  depends_on = [
    aws_eks_cluster.my_cluster,
    aws_eks_node_group.my_node_group
  ]
}

output "kubeconfig" {
  value = aws_eks_cluster_auth.cluster_auth.kubeconfig
}