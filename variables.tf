variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "environment" {
  description = "The Deployment environment"
}

variable "project_slug" {
  description = "Slug of the project"
}

variable "ec2_ami" {
  description = "AMI for the EC2 instance"
  default = "ami-09e67e426f25ce0d7"
}

variable "ssh_public_key" {
  description = "Public part of your ssh key to connect EC2 instance"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default = "10.0.0.0/16"
}
