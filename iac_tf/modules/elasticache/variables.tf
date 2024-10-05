variable "redis_instance_type" {
  description = "ElastiCache Redis instance type"
  type        = string
}

variable "redis_cluster_id" {
  description = "ElastiCache Redis Cluster ID"
  type        = string
}

variable "redis_subnet_group" {
  description = "Name of the Redis subnet group"
  type        = string
}

variable "redis_subnet_ids" {
  description = "List of subnet IDs for the Redis subnet group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security Group IDs for the Redis cluster"
  type        = list(string)
  default     = []  # Add security group IDs here
}
