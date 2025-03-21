/*
 * Get task definition data
 */
data "aws_ecs_task_definition" "td" {
  task_definition = aws_ecs_task_definition.td.family
  depends_on      = [aws_ecs_task_definition.td]
}

/*
 * Create task definition
 */
resource "aws_ecs_task_definition" "td" {
  family                = "${var.service_name}-${var.service_env}"
  container_definitions = var.container_def_json
  task_role_arn         = var.task_role_arn
  execution_role_arn    = var.execution_role_arn
  network_mode          = var.network_mode

  dynamic "volume" {
    for_each = var.volumes
    content {
      host_path = lookup(volume.value, "host_path", null)
      name      = volume.value.name

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
          scope         = lookup(docker_volume_configuration.value, "scope", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory = lookup(efs_volume_configuration.value, "root_directory", null)
        }
      }
    }
  }
}

/*
 * Create ECS Service
 */
resource "aws_ecs_service" "service" {
  name                               = var.service_name
  cluster                            = var.cluster_id
  desired_count                      = var.desired_count
  iam_role                           = var.ecsServiceRole_arn
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  availability_zone_rebalancing = var.availability_zone_rebalancing

  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy

    content {
      field = try(ordered_placement_strategy.value.field, null)
      type  = ordered_placement_strategy.value.type
    }
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer

    content {
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
      target_group_arn = load_balancer.value.target_group_arn
    }
  }

  # Track the latest ACTIVE revision
  task_definition = "${aws_ecs_task_definition.td.family}:${max(
    aws_ecs_task_definition.td.revision,
    data.aws_ecs_task_definition.td.revision,
  )}"
}
