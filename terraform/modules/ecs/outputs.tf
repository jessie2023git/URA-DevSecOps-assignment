output "cluster_id" {
  description = "The created cluster."
  value       = aws_ecs_cluster.ecs_cluster.id
}