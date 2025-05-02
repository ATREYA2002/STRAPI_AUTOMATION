terraform {
  backend "s3" {
    bucket = "strapi-ecs-prani2"
    key = "terrafrom/terrafrom.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  region = var.region
}
