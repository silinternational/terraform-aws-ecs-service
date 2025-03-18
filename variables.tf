/*
 * Required Variables
 */

variable "service_name" {
  description = "Name of the service, up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens."
  type        = string
}

variable "container_def_json" {
  description = "A list of valid container definitions provided as a single valid JSON document."
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running."
  type        = number
}


/*
 * Optional Variables
 */

variable "cluster_id" {
  description = "ARN of the ECS cluster in which to place this service. If not specified, the default cluster is used."
  type        = string
  default     = null
}

variable "service_env" {
  description = "Name of environment, used in naming task definition. Example: \"prod\"."
  type        = string
  default     = "prod"
}

variable "load_balancer" {
  description = <<-EOF
    Configuration block for load balancers.
    Attributes:
      target_group_arn - ARN of the Load Balancer target group to associate with the service.
      container_name   - Container name to associate with the load balancer (as it appears in container definition).
      container_port   - Port on the container to associate with the load balancer.
    Example:
      [{
        target_group_arn = aws_alb_target_group.this.arn
        container_name   = "app"
        container_port   = 80
      }]
    EOF
  type = list(object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  }))
  default = []
}

variable "ecsServiceRole_arn" {
  description = <<-EOF
    ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. Required if using a
    load balancer.
    EOF
  type        = string
  default     = null
}

variable "availability_zone_rebalancing" {
  description = <<-EOF
    When enabled, ECS automatically redistributes tasks within a service across Availability Zones. Must be
    either "ENABLED" or "DISABLED".
  EOF
  type        = string
  default     = "DISABLED"
}

variable "volumes" {
  description = "A list of volume definitions in JSON format that containers in your task may use"
  type        = list(any)
  default     = []
}

variable "task_role_arn" {
  description = "ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  type        = string
  default     = null
}

variable "network_mode" {
  description = <<-EOF
    Docker networking mode to use for the containers in the task. Valid values are "none", "bridge", "awsvpc",
    and "host".
    EOF
  type        = string
  default     = "bridge"
}

variable "deployment_maximum_percent" {
  description = <<-EOF
    Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a
    service during a deployment.
    EOF
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = <<-EOF
    Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running
    and healthy in a service during a deployment.
    EOF
  type        = number
  default     = 50
}

variable "ordered_placement_strategy" {
  description = "Service level strategy rules that are taken into consideration during task placement."
  type = list(object({
    type  = string
    field = string
  }))
  default = [{
    type  = "spread"
    field = "instanceId"
  }]
}

variable "execution_role_arn" {
  description = <<-EOF
    The IAM role that allows ECS to make AWS API calls on your behalf, such as to pull container images from ECR when
    using Fargate or to reference secrets from SSM Parameter Store.
    EOF
  type        = string
  default     = null
}
