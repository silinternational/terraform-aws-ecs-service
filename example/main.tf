
module "this" {
  source  = "silinternational/module_name/aws"
  version = ">= 0.1.0"

  variable_name = "a variable value"
}

module "ecsservice" {
  source  = "silinternational/ecs-service/aws"
  version = ">= 0.3.0"

  cluster_id         = module.ecscluster.ecs_cluster_id
  service_name       = var.app_name
  service_env        = var.app_env
  container_def_json = file("task-definition.json")
  desired_count      = 2
  ecsServiceRole_arn = data.terraform_remote_state.core.ecsServiceRole_arn
  load_balancer = [{
    target_group_arn = data.terraform_remote_state.cluster.alb_default_tg_arn
    container_name   = "app"
    container_port   = 80
  }]

  volumes = [
    {
      name = "vol_name"
      efs_volume_configuration = [
        {
          file_system_id = aws_efs_file_system.vol_name.id
          root_directory = "/"
        },
      ]
    },
  ]
}
