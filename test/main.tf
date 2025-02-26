
module "minimal" {
  source = "../"

  cluster_id         = ""
  service_name       = ""
  service_env        = ""
  container_def_json = ""
  desired_count      = ""
  lb_container_name  = ""
  lb_container_port  = ""
  tg_arn             = ""
  ecsServiceRole_arn = ""
}

module "full" {
  source = "../"

  cluster_id                         = ""
  service_name                       = ""
  service_env                        = ""
  container_def_json                 = ""
  desired_count                      = ""
  lb_container_name                  = ""
  lb_container_port                  = ""
  tg_arn                             = ""
  ecsServiceRole_arn                 = ""
  volumes                            = []
  task_role_arn                      = ""
  network_mode                       = ""
  deployment_maximum_percent         = ""
  deployment_minimum_healthy_percent = ""
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
