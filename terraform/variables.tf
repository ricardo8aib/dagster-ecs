# --------------------------------------------------------------------------------------------------------
# General Variables
# --------------------------------------------------------------------------------------------------------

variable "PROFILE" {
  description = "AWS Profile"
  default     = "default"
}

variable "PROJECT" {
  description = "The name of the project"
  default     = "dagstertf01"
}

variable "REGION" {
  description = "The region of the project"
  default     = "us-east-1"
}

# --------------------------------------------------------------------------------------------------------
# Subnet Variables
# --------------------------------------------------------------------------------------------------------

variable "SUBNET_IDS_FOR_DAGSTER_WEBSERVER" {
  description = "List of subnet IDs for Dagster Webserver ECS Service"
  type        = list(string)
  default = [
    "subnet-002e6359f5808e9ff",
    "subnet-0fedf1baee229d125",
    "subnet-0277f68161faa9443",
    "subnet-00699a1ab012cf489",
    "subnet-049ec122d83dd3841",
    "subnet-0c647967aed26a668"
  ]
}

variable "SUBNET_IDS_FOR_DAGSTER_DAEMON" {
  description = "List of subnet IDs for Dagster Daemon ECS Service (private subnet recommended)"
  type        = list(string)
  default = [
    "subnet-002e6359f5808e9ff",
    "subnet-0fedf1baee229d125",
    "subnet-0277f68161faa9443",
    "subnet-00699a1ab012cf489",
    "subnet-049ec122d83dd3841",
    "subnet-0c647967aed26a668"
  ]
}

variable "SUBNET_IDS_FOR_DAGSTER_CODE_LOCATION" {
  description = "List of subnet IDs for Dagster Code Location ECS Service (private subnet recommended)"
  type        = list(string)
  default = [
    "subnet-002e6359f5808e9ff",
    "subnet-0fedf1baee229d125",
    "subnet-0277f68161faa9443",
    "subnet-00699a1ab012cf489",
    "subnet-049ec122d83dd3841",
    "subnet-0c647967aed26a668"
  ]
}

variable "SUBNET_IDS_FOR_EFS" {
  description = "List of subnet IDs for EFS"
  type        = list(string)
  default = [
    "subnet-002e6359f5808e9ff",
    "subnet-0fedf1baee229d125",
    "subnet-0277f68161faa9443",
    "subnet-00699a1ab012cf489",
    "subnet-049ec122d83dd3841",
    "subnet-0c647967aed26a668"
  ]
}

variable "SUBNET_ARN_FOR_DATASYNC_TASK" {
  description = "The ARN of the subnet for DataSync Task (private subnet recommended)"
  default     = "arn:aws:ec2:us-east-1:183295420890:subnet/subnet-0fedf1baee229d125"
}

# --------------------------------------------------------------------------------------------------------
# Networking Variables
# --------------------------------------------------------------------------------------------------------

variable "DAGSTER_DATABASE_SG_VPC" {
  description = "The VPC where the database is going to be located"
  default     = "vpc-09a0ebdb974f0fb80"
}

variable "DAGSTER_DATABASE_SUBNET_GROUP" {
  description = <<EOT
    This is the name of the RDS Subnet group. You can check the RDS subnet
    groups by going to RDS and then to Subnet "groups".

    The subnet group has to be associated with the VPC defined in "DAGSTER_DATABASE_SG_VPC".
    If no subnet group is specified, terraform will use the default subnet group, but, if
    the value defined in the "DAGSTER_DATABASE_SG_VPC" variable is not the default VPC, you
    will get an error.
  EOT
  default     = "default"
}

variable "DAGSTER_DATABASE_SG_NAME" {
  description = "The name of the dagster db security group"
  default     = "Dagster Database SGtf01"
}

variable "DAGSTER_SERVICES_SG_NAME" {
  description = "The name of the dagster services security group"
  default     = "Dagster Services SGtf01"
}

# --------------------------------------------------------------------------------------------------------
# ECR Variables
# --------------------------------------------------------------------------------------------------------

variable "DAGSTER_CODE_LOCATION_ECR_REPO_NAME" {
  description = "The name of the code location ECR repository"
  default     = "coing-analytics-dagster-code-locationtf01"
}

variable "DAGSTER_WEB_SERVER_ECR_REPO_NAME" {
  description = "The name of the web server ECR repository"
  default     = "coing-analytics-dagster-web-servertf01"
}

variable "DAGSTER_DAEMON_ECR_REPO_NAME" {
  description = "The name of the daemon ECR repository"
  default     = "coing-analytics-dagster-daemontf01"
}

# --------------------------------------------------------------------------------------------------------
# S3 Variables
# --------------------------------------------------------------------------------------------------------

variable "BUCKET_NAME" {
  description = "The name of the Bucket"
  default     = "dagster-code-location-poc-buckettf01"
}

# --------------------------------------------------------------------------------------------------------
# RDS Variables
# --------------------------------------------------------------------------------------------------------

variable "ENGINE" {
  description = "The db engine"
  default     = "postgres"
}

variable "ENGINE_VERSION" {
  description = "The db engine version"
  default     = "15.7"
}

variable "DB_INSTANCE_CLASS" {
  description = "The instance class for the database"
  default     = "db.t3.micro"
}

variable "DB_IDENTIFIER" {
  description = "The cluster identifier"
  default     = "dagsterdb-clustertf01"
}

variable "DB_NAME" {
  description = "The name of the database"
  default     = "dagsterdbtf01"
}

variable "DB_USERNAME" {
  description = "The master username for the database"
  default     = "postgres"
}

variable "DB_PASSWORD" {
  description = "The master password for the database (use secret management in production)"
  default     = "YourMasterPassword123!"
}

variable "BACKUP_RETENTION_PERIOD" {
  description = "The retention period for backups in days"
  default     = 7
}

# --------------------------------------------------------------------------------------------------------
# EFS Variables
# --------------------------------------------------------------------------------------------------------

variable "EFS_NAME" {
  description = "The name of the EFS"
  default     = "dagster-code-location-volume-efstf01"
}

variable "ACCESS_NAME" {
  description = "The name of the access point"
  default     = "code-location-access-pointtf1"
}

# --------------------------------------------------------------------------------------------------------
# IAM Variables
# --------------------------------------------------------------------------------------------------------

variable "DATASYNC_ROLE_NAME" {
  description = "The name of the datasync role"
  default     = "dagster-datasync-task-roletf01"
}

variable "DATASYNC_POLICY_NAME" {
  description = "The name of the datasync policy"
  default     = "dagster-datasync-task-policytf01"
}

variable "ECS_ROLE_NAME" {
  description = "The name of the ECS role"
  default     = "dagster-ecs-roletf01"
}

variable "ECS_POLICY_NAME" {
  description = "The name of the ECS policy"
  default     = "dagster-ecs-policytf01"
}

# --------------------------------------------------------------------------------------------------------
# DataSync Variables
# --------------------------------------------------------------------------------------------------------

variable "DATASYNC_TASK_NAME" {
  description = "The name of the DataSync task"
  type        = string
  default     = "dagster_datasync_task_code_locationtf01"
}

# --------------------------------------------------------------------------------------------------------
# ECS Variables
# --------------------------------------------------------------------------------------------------------

# General Variables
variable "ECS_CLUSTER_NAME" {
  description = "The name of the ECS cluster"
  default     = "dagster-clustertf01"
}

variable "NAMESPACE_NAME" {
  description = "The name of Namespace"
  default     = "dagster-services-namespacetf01"
}

variable "CODE_LOCATION_TASK_FAMILY_NAME" {
  description = "The name of the code location task family"
  default     = "dagster-code-location-task-definition"
}

variable "CODE_LOCATION_CONTAINER_NAME" {
  description = "The name of the code location container"
  default     = "dagster-code-location"
}

variable "CODE_LOCATION_MODULE_PATH" {
  description = "The name or path of the module that will be used to start the code location server."
  default     = "dagster_university"
}

variable "CODE_LOCATION_VOLUME_NAME" {
  description = "The name of the volume that will be created for the code location container."
  default     = "dagster-efs-volume"
}

variable "EFS_CODE_LOCATION_VOLUME_PATH" {
  description = "The path in the EFS that will be attached to the container."
  default     = "/dagster-code-location"
}

# Dagster Runs variables
variable "DAGSTER_RUNS_TASK_FAMILY_NAME" {
  description = "The name of the Dagster runs task family"
  default     = "dagster-runs-task-definition"
}

variable "DAGSTER_RUNS_CONTAINER_NAME" {
  description = "The name of the dagster runs container"
  default     = "dagster-run"
}

variable "DAEMON_TASK_FAMILY_NAME" {
  description = "The name of the Daemon task family"
  default     = "dagster-daemon-task-definition"
}

variable "DAEMON_CONTAINER_NAME" {
  description = "The name of the Daemon container"
  default     = "dagster-daemon"
}

variable "WEBSERVER_TASK_FAMILY_NAME" {
  description = "The name of the Web Server task family"
  default     = "dagster-webserver-task-definition"
}

variable "WEBSERVER_CONTAINER_NAME" {
  description = "The name of the Daemon container"
  default     = "dagster-webserver"
}
