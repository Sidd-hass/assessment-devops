variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "alb_security_group_id" {
  type = string
}

variable "ecs_security_group_id" {
  type = string
}

variable "container_image" {
  description = "Any simple image, e.g. nginx."
  type        = string
  default     = "nginx:1.27-alpine"
}

variable "container_port" {
  type    = number
  default = 80
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "task_cpu" {
  description = "Fargate CPU units (256, 512, 1024, ...)."
  type        = number
}

variable "task_memory" {
  description = "Fargate memory in MiB."
  type        = number
}

variable "desired_count" {
  type = number
}

variable "db_host" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_name" {
  type = string
}

variable "db_secret_arn" {
  description = "Secrets Manager ARN with the DB master credentials."
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN. When set, ALB serves HTTPS and redirects HTTP to HTTPS."
  type        = string
  default     = ""
}

variable "alb_deletion_protection" {
  type    = bool
  default = false
}

variable "log_retention_days" {
  type    = number
  default = 14
}
