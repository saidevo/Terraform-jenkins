terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}