environment = "prod"
region      = "ap-south-1"

# network
vpc_cidr           = "10.20.0.0/16"
azs                = ["ap-south-1a", "ap-south-1b"]
single_nat_gateway = false

# ECS / ALB
container_image         = "nginx:1.27-alpine"
container_port          = 80
task_cpu                = 1024
task_memory             = 2048
desired_count           = 3
alb_deletion_protection = true
log_retention_days      = 90
certificate_arn         = "" # set an ACM ARN to enable HTTPS

# RDS
db_engine_version        = "16"
db_instance_class        = "db.m6g.large"
db_allocated_storage     = 100
db_max_allocated_storage = 500
db_name                  = "hotel"
db_username              = "app"
db_multi_az              = true
db_backup_retention_days = 14
db_deletion_protection   = true
db_performance_insights  = true
