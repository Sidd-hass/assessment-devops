variable "name" {
  description = "Name prefix for all resources (e.g. hotel-dev)."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC."
  type        = string
}

variable "azs" {
  description = "Availability zones to span (one public + one private subnet each)."
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "true = one shared NAT gateway (cheaper, dev). false = one NAT per AZ (HA, prod)."
  type        = bool
  default     = true
}

variable "container_port" {
  description = "Port the application container listens on."
  type        = number
  default     = 80
}

variable "db_port" {
  description = "Database port (5432 for PostgreSQL)."
  type        = number
  default     = 5432
}
