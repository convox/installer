variable "domain" {
  description = "rack base domain, you will need to alias *.domain to the output named endpoint"
  type        = "string"
}

variable "name" {
  description = "rack name"
  default     = "convox"
}

variable "release" {
  description = "convox release version to install"
  default     = "master"
}

variable "region" {
  description = "aws region in which to install the rack"
  default     = "us-east-1"
}

variable "ssh_key" {
  description = "ssh key name to install on nodes"
  default     = ""
}

provider "aws" {
  version = "~> 2.22"

  region = var.region
}

module "system" {
  source = "github.com/convox/terraform//system/aws"

  domain  = var.domain
  name    = var.name
  release = var.release
  ssh_key = var.ssh_key

  providers = {
    aws = aws
  }
}

output "endpoint" {
  value = module.system.router
}

output "rack_url" {
  value = module.system.api
}
