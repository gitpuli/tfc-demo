output "cluster_id" {
  value       = aws_eks_cluster.this.id
  description = "The name/id of the EKS cluster"
}

output "eks_cluster" {
  value     = aws_eks_cluster.this
  description = "eks cluster"

}