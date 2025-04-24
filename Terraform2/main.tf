terraform {
  backend "s3" {
    bucket = "strapi-ecs-prani"
    key = "terrafrom/terrafrom.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  region = var.region
}