variable "DAGSTER_DATABASE_SG_NAME" {
  description = "The name of the dagster db security group"
}

variable "DAGSTER_DATABASE_SG_VPC" {
  description = "The VPC where the database is"
  type        = string
}

variable "DAGSTER_SERVICES_SG_NAME" {
  description = "The name of the dagster services security group"
}