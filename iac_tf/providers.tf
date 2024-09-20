terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }

  backend "s3" {
    bucket         = "tf-microsvc-backend"
    key            = "tf-state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-tbl-be"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}