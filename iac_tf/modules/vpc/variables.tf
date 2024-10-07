variable "public_subnets" {
  description = "Map of Public Subnet CIDR blocks"
  type        = map(string)
  default     = {
    "subnet-01" = "10.1.0.0/22", 
    "subnet-02" = "10.1.4.0/22"
  }
}

variable "private_subnets" {
  description = "Map of Private Subnet CIDR blocks"
  type        = map(string)
  default     = {
     "subnet-01" = "10.1.8.0/22", 
     "subnet-02" = "10.1.12.0/22"
  }
}

