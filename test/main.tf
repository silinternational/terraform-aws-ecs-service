
module "minimal" {
  source = "../"

  cluster_id         = ""
  service_name       = ""
  service_env        = ""
  container_def_json = ""
  desired_count      = "1"
  lb_container_name  = ""
  lb_container_port  = "80"
  tg_arn             = ""
  ecsServiceRole_arn = ""
}

module "full" {
  source = "../"

  cluster_id         = ""
  service_name       = ""
  service_env        = ""
  container_def_json = ""
  desired_count      = "1"
  lb_container_name  = ""
  lb_container_port  = "80"
  tg_arn             = ""
  ecsServiceRole_arn = ""

  availability_zone_rebalancing      = true
  volumes                            = []
  task_role_arn                      = ""
  network_mode                       = "bridge"
  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "50"
  ordered_placement_strategy = [
    {
      type  = "spread"
      field = "attribute:ecs.availability-zone"
    },
    {
      type  = "spread"
      field = "instanceId"
    }
  ]
}

output "task_def_arn" {
  value = module.minimal.task_def_arn
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
