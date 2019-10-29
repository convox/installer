variable "name" {
  description = "rack name"
  default     = "convox"
}

variable "node_type" {
  description = "machine type of the cluster nodes"
  default     = "t3.small"
}

variable "release" {
  description = "convox release version to install"
  default     = ""
}

variable "region" {
  description = "aws region in which to install the rack"
  default     = "us-east-1"
}

variable "ssh_key" {
  description = "ssh key name to install on nodes"
  default     = ""
}

variable "zone" {
  description = "name of route53 hosted zone in which to add a cname for this rack"
  type        = "string"
}

locals {
  domain = "${var.name}.${replace(data.aws_route53_zone.zone.name, "/^(.*)\\.$/", "$1")}"
}

provider "aws" {
  version = "~> 2.22"

  region = var.region
}

data "aws_route53_zone" "zone" {
  zone_id = var.zone
}

resource "aws_route53_record" "system" {
  name    = "*.${var.name}"
  type    = "CNAME"
  ttl     = 60
  records = [module.system.router]
  zone_id = var.zone
}

module "system" {
  source = "github.com/convox/convox//terraform/system/aws"

  domain    = local.domain
  name      = var.name
  node_type = var.node_type
  release   = var.release
  ssh_key   = var.ssh_key

  providers = {
    aws = aws
  }
}

output "rack_url" {
  value = module.system.api
}
