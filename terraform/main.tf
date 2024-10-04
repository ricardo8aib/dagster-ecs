module "ecr" {
  source                              = "./modules/ecr"
  DAGSTER_CODE_LOCATION_ECR_REPO_NAME = var.DAGSTER_CODE_LOCATION_ECR_REPO_NAME
  DAGSTER_DAEMON_ECR_REPO_NAME        = var.DAGSTER_DAEMON_ECR_REPO_NAME
  DAGSTER_WEB_SERVER_ECR_REPO_NAME    = var.DAGSTER_WEB_SERVER_ECR_REPO_NAME
}

module "networking" {
  source                   = "./modules/networking"
  DAGSTER_DATABASE_SG_VPC  = var.DAGSTER_DATABASE_SG_VPC
  DAGSTER_DATABASE_SG_NAME = var.DAGSTER_DATABASE_SG_NAME
  DAGSTER_SERVICES_SG_NAME = var.DAGSTER_SERVICES_SG_NAME

}

module "s3" {
  source      = "./modules/s3"
  BUCKET_NAME = var.BUCKET_NAME
}

module "rds" {
  source                        = "./modules/rds"
  DAGSTER_DATABASE_SG_ID        = module.networking.security_group_ids["dagster_database_sg"]
  REGION                        = var.REGION
  ENGINE                        = var.ENGINE
  ENGINE_VERSION                = var.ENGINE_VERSION
  DB_INSTANCE_CLASS             = var.DB_INSTANCE_CLASS
  DB_IDENTIFIER                 = var.DB_IDENTIFIER
  DB_NAME                       = var.DB_NAME
  DB_USERNAME                   = var.DB_USERNAME
  DB_PASSWORD                   = var.DB_PASSWORD
  BACKUP_RETENTION_PERIOD       = var.BACKUP_RETENTION_PERIOD
  DAGSTER_DATABASE_SUBNET_GROUP = var.DAGSTER_DATABASE_SUBNET_GROUP
}

module "efs" {
  source                 = "./modules/efs"
  DAGSTER_SERVICES_SG_ID = module.networking.security_group_ids["dagster_services_sg"]
  ACCESS_NAME            = var.ACCESS_NAME
  EFS_NAME               = var.EFS_NAME
  SUBNET_IDS             = var.SUBNET_IDS_FOR_EFS
}

module "IAM" {
  source                                   = "./modules/IAM"
  ECS_ROLE_NAME                            = var.ECS_ROLE_NAME
  ECS_POLICY_NAME                          = var.ECS_POLICY_NAME
  DATASYNC_POLICY_NAME                     = var.DATASYNC_POLICY_NAME
  DATASYNC_ROLE_NAME                       = var.DATASYNC_ROLE_NAME
  CODE_LOCATION_BUCKET_ARN                 = module.s3.code_location_bucket_arn["code_location_bucket_arn"]
  EFS_ARN                                  = module.efs.efs["efs_arn"]
  EVENTBRIDGE_DATASYNC_EXECUTION_ROLE_NAME = var.EVENTBRIDGE_DATASYNC_EXECUTION_ROLE_NAME
}

module "datasync" {
  source                    = "./modules/datasync"
  DATASYNC_TASK_ROLE_ARN    = module.IAM.datasync_role["datasync_role_arn"]
  CODE_LOCATION_BUCKET_ARN  = module.s3.code_location_bucket_arn["code_location_bucket_arn"]
  EFS_ARN                   = module.efs.efs["efs_arn"]
  DAGSTER_SERVICES_SG_ARN   = module.networking.security_group_ids["dagster_services_sg_arn"]
  SUBNET_ARN                = var.SUBNET_ARN_FOR_DATASYNC_TASK
  DATASYNC_TASK_NAME        = var.DATASYNC_TASK_NAME
  CODE_LOCATION_BUCKET_NAME = var.BUCKET_NAME
}

module "ecs" {
  source                               = "./modules/ecs"
  DATABASE_HOST                        = module.rds.db_instance["db_instance_endpoint"]
  DATABASE_NAME                        = module.rds.db_instance["db_name"]
  DATABASE_USERNAME                    = module.rds.db_instance["db_username"]
  DATABASE_PASSWORD                    = module.rds.db_instance["db_password"]
  TASK_ROLE_ARN                        = module.IAM.ecs_role["ecs_role_arn"]
  TASK_EXECUTION_ROLE_ARN              = module.IAM.ecs_role["ecs_role_arn"]
  EFS_ID                               = module.efs.efs["efs_id"]
  VPC_ID                               = var.DAGSTER_DATABASE_SG_VPC
  DAGSTER_SERVICES_SG                  = module.networking.security_group_ids["dagster_services_sg"]
  SUBNET_IDS_FOR_DAGSTER_WEBSERVER     = var.SUBNET_IDS_FOR_DAGSTER_WEBSERVER
  SUBNET_IDS_FOR_DAGSTER_DAEMON        = var.SUBNET_IDS_FOR_DAGSTER_DAEMON
  SUBNET_IDS_FOR_DAGSTER_CODE_LOCATION = var.SUBNET_IDS_FOR_DAGSTER_CODE_LOCATION
  CODE_LOCATION_IMAGE                  = module.ecr.dagster_ecr_urls["dagster_code_location"]
  DAEMON_IMAGE                         = module.ecr.dagster_ecr_urls["dagster_daemon"]
  WEBSERVER_IMAGE                      = module.ecr.dagster_ecr_urls["dagster_web_server"]
  CODE_LOCATION_VOLUME_NAME            = var.CODE_LOCATION_VOLUME_NAME
  DAEMON_CONTAINER_NAME                = var.DAEMON_CONTAINER_NAME
  DAGSTER_RUNS_TASK_FAMILY_NAME        = var.DAGSTER_RUNS_TASK_FAMILY_NAME
  CODE_LOCATION_TASK_FAMILY_NAME       = var.CODE_LOCATION_TASK_FAMILY_NAME
  ECS_CLUSTER_NAME                     = var.ECS_CLUSTER_NAME
  DAGSTER_RUNS_CONTAINER_NAME          = var.DAGSTER_RUNS_CONTAINER_NAME
  CODE_LOCATION_MODULE_PATH            = var.CODE_LOCATION_MODULE_PATH
  EFS_CODE_LOCATION_VOLUME_PATH        = var.EFS_CODE_LOCATION_VOLUME_PATH
  DAEMON_TASK_FAMILY_NAME              = var.DAEMON_TASK_FAMILY_NAME
  NAMESPACE_NAME                       = var.NAMESPACE_NAME
  WEBSERVER_TASK_FAMILY_NAME           = var.WEBSERVER_TASK_FAMILY_NAME
  WEBSERVER_CONTAINER_NAME             = var.WEBSERVER_CONTAINER_NAME
  CODE_LOCATION_CONTAINER_NAME         = var.CODE_LOCATION_CONTAINER_NAME
}
