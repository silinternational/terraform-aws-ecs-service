# ECS Service

This module is used to create an ECS service and task definition

# Terraform Registry

This module is published in [Terraform Registry](https://registry.terraform.io/modules/silinternational/ecs-service/aws/latest).

# Usage Example

```hcl
module "ecsservice" {
  source  = "silinternational/ecs-service/aws"
  version = ">= 0.2.0"

  cluster_id         = module.ecscluster.ecs_cluster_id
  service_name       = var.app_name
  service_env        = var.app_env
  container_def_json = file("task-definition.json")
  desired_count      = 2
  tg_arn             = data.terraform_remote_state.cluster.alb_default_tg_arn
  lb_container_name  = "app"
  lb_container_port  = 80
  ecsServiceRole_arn = data.terraform_remote_state.core.ecsServiceRole_arn
}
```

An [example](https://github.com/silinternational/terraform-aws-ecs-service/tree/main/example) usage of this module is included in the source repository.
