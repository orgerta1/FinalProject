# ECR

resource "aws_ecr_repository" "ecr-repository" {
  name = "${var.APP_NAME}-ecr-repository"
}

# EKS cluster roles and policies

resource "aws_iam_role" "eks-cluster-role" {
  name               = "${var.APP_NAME}-eks-cluster-role"
  assume_role_policy = file("${path.module}/templates/eks-cluster-role.json.tpl")
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

# EKS node group roles and policies

resource "aws_iam_role" "eks-node-group-role" {
  name               = "${var.APP_NAME}-eks-node-group-role"
  assume_role_policy = file("${path.module}/templates/eks-ec2-role.json.tpl")
}

resource "aws_iam_role_policy_attachment" "eks-worker-nodes-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-nodes-cni-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "ecr-readonly-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-nodes-cloudwatch-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.eks-node-group-role.name
}

# EKS cluster & node group

resource "aws_eks_cluster" "eks-cluster" {
  name     = "${var.APP_NAME}-eks-cluster"
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    subnet_ids = var.PUBLIC_SUBNET_IDS
  }

  depends_on = [aws_iam_role_policy_attachment.eks-cluster-policy-attachment]
}

resource "aws_eks_node_group" "eks-cluster-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "${var.APP_NAME}-eks-cluster-node-group"
  node_role_arn   = aws_iam_role.eks-node-group-role.arn

  subnet_ids = var.PUBLIC_SUBNET_IDS

  capacity_type  = "ON_DEMAND"
  instance_types = [var.EKS_WORKER_NODE_INSTANCE_TYPE]

  scaling_config {
    desired_size = var.EKS_CLUSTER_DESIRED_SIZE
    max_size     = var.EKS_CLUSTER_MAX_SIZE
    min_size     = var.EKS_CLUSTER_MIN_SIZE
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-worker-nodes-policy-attachment,
    aws_iam_role_policy_attachment.eks-worker-nodes-cni-policy-attachment,
    aws_iam_role_policy_attachment.ecr-readonly-policy-attachment,
    aws_iam_role_policy_attachment.eks-worker-nodes-cloudwatch-policy-attachment
  ]
}
