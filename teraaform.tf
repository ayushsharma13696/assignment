variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "app_name" {
    default = "dockerapp"
}
variable "app_environment" {
    default = "dockerapp"
}
variable "chart_name" {
    default = ""
}
terraform {
  required_version = ">= 0.12"
}
provider "aws" {
  version = "~> 2.12"
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
resource "aws_vpc" "aws-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "docker-vpc"
  }
}
resource "aws_subnet" "aws-subnet" {
  count = length(data.aws_availability_zones.aws-az.names)
  vpc_id = aws_vpc.aws-vpc.id
  cidr_block = cidrsubnet(aws_vpc.aws-vpc.cidr_block, 8, count.index + 1)
  availability_zone = data.aws_availability_zones.aws-az.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.app_name}-subnet-${count.index + 1}"
    Environment = var.app_environment
  }
}
resource "aws_alb" "main" {
  name = "${var.app_name}-load-balancer"
  subnets = aws_subnet.aws-subnet.*.id
  security_groups = [aws_security_group.aws-lb.id]
  tags = {
    Name = "${var.app_name}-alb"
  }
}
provider "helm" {
  kubernetes {
    config_path = "/path/to/KUBECONFIG"
  }
}
resource "helm_release" "deploy" {
  name  = "${var.app_name}"
  chart = "${var.chart_name}"
}
