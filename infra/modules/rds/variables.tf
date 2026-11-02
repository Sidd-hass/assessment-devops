variable "name" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "rds_security_group_id" {
  type = string
}

variable "engine_version" {
  description = "PostgreSQL version (major or full)."
  type        = string
  default     = "16"
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  description = "Initial storage in GiB."
  type        = number
}

variable "max_allocated_storage" {
  description = "Storage autoscaling ceiling in GiB (0 disables)."
  type        = number
  default     = 0
}

variable "db_name" {
  type    = string
  default = "hotel"
}

variable "db_username" {
  type    = string
  default = "app"
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  description = "Days to keep automated backups (0-35)."
  type        = number
}

variable "deletion_protection" {
  type = bool
}

variable "performance_insights_enabled" {
  type    = bool
  default = false
}

variable "backup_window" {
  type    = string
  default = "21:00-22:00" # UTC
}

variable "maintenance_window" {
  type    = string
  default = "sun:22:30-sun:23:30" # UTC
}
