output "alb_dns_name" {
  value = module.ecs.alb_dns_name
}

output "rds_endpoint" {
  value = module.rds.address
}

output "vpc_id" {
  value = module.network.vpc_id
}
