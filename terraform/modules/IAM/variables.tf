variable "DATASYNC_ROLE_NAME" {
  description = "The name of the datasync role"
  type        = string
}

variable "DATASYNC_POLICY_NAME" {
  description = "The name of the datasync policy"
  type        = string
}

variable "ECS_ROLE_NAME" {
  description = "The name of the ECS role"
  type        = string
}

variable "ECS_POLICY_NAME" {
  description = "The name of the ECS policy"
  type        = string
}

variable "EVENTBRIDGE_DATASYNC_EXECUTION_ROLE_NAME" {
  description = "The name of the IAM role that allows EventBridge to invoke the StartTaskExecution action for DataSync"
  type        = string
}

variable "EVENTBRIDGE_DATASYNC_EXECUTION_POLICY_NAME" {
  description = "The name of the IAM policy that allows EventBridge to invoke the StartTaskExecution action for DataSync"
  type        = string
}

variable "DATASYNC_TASK_ARN" {
  description = "The ARN of the datasync task for the EventBridge Datasync execution policy"
  type        = string
}

variable "CODE_LOCATION_BUCKET_ARN" {
  description = "The arn of the code location bucket"
  type        = string
}

variable "EFS_ARN" {
  description = "The arn of the EFS"
  type        = string
}
