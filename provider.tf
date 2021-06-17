terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.45.0"
    }
  }
}

provider "aws" {
//  profile = "profile"
  region  = var.region
}
