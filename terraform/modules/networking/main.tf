# Define the security group for the Dagster Database
resource "aws_security_group" "dagster_database_sg" {
  name        = var.DAGSTER_DATABASE_SG_NAME
  description = "Security group for the Dagster database"
  vpc_id      = var.DAGSTER_DATABASE_SG_VPC

  # Allow all outbound traffic
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow PostgreSQL from MY IP"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["190.84.116.40/32"]
  }

  tags = {
    Name = "Dagster Database SGtf01"
  }
}

# Define the security group for Dagster Services
resource "aws_security_group" "dagster_services_sg" {
  name        = var.DAGSTER_SERVICES_SG_NAME
  description = "Security group for the Dagster services"
  vpc_id      = var.DAGSTER_DATABASE_SG_VPC
  depends_on = [aws_security_group.dagster_database_sg]

  # Allow all outbound traffic
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow All Traffic From my IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["190.84.116.40/32"]
  }

  # Allow inbound traffic from the Dagster database security group
  ingress {
    description = "Allow traffic from Dagster database"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.dagster_database_sg.id]
  }

  # Allow traffic from itself (self-referencing security group)
  ingress {
    description = "Allow traffic within Dagster services (SELF)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  tags = {
    Name = "Dagster Services SGtf01"
  }
}

# Define specific ingress rules using aws_security_group_rule
resource "aws_security_group_rule" "dagster_to_db" {
  type                   = "ingress"
  from_port              = 5432
  to_port                = 5432
  protocol               = "tcp"
  security_group_id      = aws_security_group.dagster_database_sg.id
  source_security_group_id = aws_security_group.dagster_services_sg.id
}
