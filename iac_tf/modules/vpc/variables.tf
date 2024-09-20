variable "public_subnets" {
  description = "List of Public Subnet CIDR blocks"
  type        = list(string)
  default     = ["10.1.4.0/22", "10.1.8.0/22"]
}

variable "private_subnets" {
  description = "List of Private Subnet CIDR blocks"
  type        = list(string)
  default     = ["10.1.10.0/22", "10.1.12.0/22"]
}

