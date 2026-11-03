environment = "dev"
region      = "ap-south-1"
plan_only   = true # review mode, see providers.tf. Set false (and delete backend_override.tf) to deploy

# network
vpc_cidr           = "10.10.0.0/16"
azs                = ["ap-south-1a", "ap-south-1b"]
single_nat_gateway = true

# ECS / ALB
container_image         = "nginx:1.27-alpine"
container_port          = 80
task_cpu                = 256
task_memory             = 512
desired_count           = 1
alb_deletion_protection = false
log_retention_days      = 7
certificate_arn         = "" # set an ACM ARN to enable HTTPS

# RDS
db_engine_version        = "16"
db_instance_class        = "db.t4g.micro"
db_allocated_storage     = 20
db_max_allocated_storage = 50
db_name                  = "hotel"
db_username              = "app"
db_multi_az              = false
db_backup_retention_days = 3
db_deletion_protection   = false
db_performance_insights  = false
