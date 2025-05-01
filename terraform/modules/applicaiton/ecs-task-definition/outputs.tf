output "task_definition_arn" {
  value = length(aws_ecs_task_definition.application_task) > 0 ? aws_ecs_task_definition.application_task.arn : null
}