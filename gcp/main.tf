variable "credentials" {
  description = "path to json credentials file (create one at https://console.cloud.google.com/apis/credentials/serviceaccountkey)"
  default     = "~/.config/gcloud/terraform.json"
}

variable "domain" {
  description = "domain name to use for rack (you will need to CNAME this domain to the output named hostname)"
  type        = "string"
}

variable "name" {
  description = "rack name"
  default     = "convox"
}

variable "project" {
  description = "gcp project in which to install the rack"
  type        = "string"
}

variable "release" {
  description = "convox release version to install"
  default     = "master"
}

variable "region" {
  description = "gcp version in which to install the rack"
  default     = "us-east1"
}

locals {
  domain = "${var.name}.${replace(data.google_dns_managed_zone.zone.dns_name, "/^(.*)\\.$/", "$1")}"
}

provider "google" {
  version = "~> 2.12"

  credentials = pathexpand(var.credentials)
  project     = var.project
  region      = var.region
}

module "system" {
  source = "github.com/convox/terraform//system/gcp"

  domain  = var.domain
  name    = var.name
  release = var.release

  providers = {
    google = google
  }
}

output "hostname" {
  value = module.system.endpoint
}

output "rack_url" {
  value = module.system.api
}
