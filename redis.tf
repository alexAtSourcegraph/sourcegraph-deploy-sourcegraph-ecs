resource "aws_elasticache_cluster" "redis_store" {
  cluster_id               = "${var.cluster_name}-redis-store"
  engine                   = "redis"
  node_type                = "cache.m4.large"
  num_cache_nodes          = 1
  parameter_group_name     = "default.redis3.2"
  engine_version           = "3.2.10"
  port                     = 6379
  snapshot_retention_limit = 30 # days
  subnet_group_name        = aws_elasticache_subnet_group.redis.name
  security_group_ids       = [module.ec2_security_group.security_group_id]
}

resource "aws_elasticache_cluster" "redis_cache" {
  cluster_id           = "${var.cluster_name}-redis-cache"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [module.ec2_security_group.security_group_id]
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.cluster_name}-redis"
  subnet_ids = module.ecs_vpc.private_subnets
}
