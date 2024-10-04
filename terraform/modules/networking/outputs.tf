output "security_group_ids" {
  value = {
    dagster_database_sg     = aws_security_group.dagster_database_sg.id
    dagster_services_sg     = aws_security_group.dagster_services_sg.id
    dagster_services_sg_arn = aws_security_group.dagster_services_sg.arn
  }
}

