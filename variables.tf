/*
 * Required Variables
 */

variable "cluster_id" {
  type = string
}

variable "service_name" {
  type = string
}

variable "service_env" {
  type = string
}

variable "container_def_json" {
  type = string
}

variable "desired_count" {
  type = string
}

variable "lb_container_name" {
  type = string
}

variable "lb_container_port" {
  type = string
}

variable "tg_arn" {
  type = string
}

variable "ecsServiceRole_arn" {
  type = string
}

/*
 * Optional Variables
 */

variable "availability_zone_rebalancing" {
  description = <<EOF
    "When enabled, ECS automatically redistributes tasks within a service across Availability Zones. Must be
    "either \"ENABLED\" or \"DISABLED\"."
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
  type    = string
  default = ""
}

variable "network_mode" {
  type    = string
  default = "bridge"
}

variable "deployment_maximum_percent" {
  type    = string
  default = 200
}

variable "deployment_minimum_healthy_percent" {
  type    = string
  default = 50
}

variable "ordered_placement_strategy" {
  description = ""
  type        = list(any)
  default = [{
    type  = "spread"
    field = "instanceId"
  }]
}
