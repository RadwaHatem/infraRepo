resource "aws_eks_cluster" "eks-cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    
    endpoint_private_access = true
    endpoint_public_access  = false
    subnet_ids = [module.my-network.priv_sub_1,module.my-network.priv_sub_2]
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks-attach-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-attach-AmazonEKSVPCResourceController,
  ]
}