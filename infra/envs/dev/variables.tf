variable "project" {
  type    = string
  default = "hotel"
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "plan_only" {
  description = "true = review mode: dummy AWS credentials, no AWS API calls (plan -refresh=false only). false = real deployment."
  type        = bool
  default     = false
}

# ---- network ----
variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "single_nat_gateway" {
  type = bool
}

# ---- ECS / ALB ----
variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "task_cpu" {
  type = number
}

variable "task_memory" {
  type = number
}

variable "desired_count" {
  type = number
}

variable "certificate_arn" {
  description = "ACM certificate ARN for the ALB HTTPS listener (empty = HTTP only)."
  type        = string
  default     = ""
}

variable "alb_deletion_protection" {
  type = bool
}

variable "log_retention_days" {
  type = number
}

# ---- RDS ----
variable "db_engine_version" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_allocated_storage" {
  type = number
}

variable "db_max_allocated_storage" {
  type = number
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_multi_az" {
  type = bool
}

variable "db_backup_retention_days" {
  type = number
}

variable "db_deletion_protection" {
  type = bool
}

variable "db_performance_insights" {
  type = bool
}
