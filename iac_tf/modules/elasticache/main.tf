resource "aws_elasticache_subnet_group" "url_shortener_redis_subnet_group" {
  name       = var.redis_subnet_group
  subnet_ids = var.redis_subnet_ids
}

resource "aws_elasticache_cluster" "url_shortener_redis" {
  cluster_id           = var.redis_cluster_id
  engine               = "redis"
  engine_version       = 7.1
  node_type            = var.redis_instance_type
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.url_shortener_redis_subnet_group.name
  security_group_ids   = var.security_group_ids
}