/*
 * Task definition outputs
 */
output "task_def_arn" {
  description = "ARN of the task definition"
  value       = aws_ecs_task_definition.td.arn
}

output "task_def_family" {
  description = "Family of the task definition"
  value       = aws_ecs_task_definition.td.family
}

output "task_def_revision" {
  description = "Revision number of the task definition"
  value       = aws_ecs_task_definition.td.revision
}

/*
 * Service outputs
 */
output "service_id" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.service.id
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.service.name
}

output "service_cluster" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_service.service.cluster
}

output "service_role" {
  description = "ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf"
  value       = aws_ecs_service.service.iam_role
}

output "service_desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  value       = aws_ecs_service.service.desired_count
}
