variable "credentials" {
  description = "path to credentials, create at https://console.cloud.google.com/apis/credentials/serviceaccountkey"
  default     = "~/.config/gcloud/terraform.json"
}

variable "name" {
  description = "rack name"
  default     = "convox"
}

variable "node_type" {
  description = "machine type of the cluster nodes"
  default     = "n1-standard-1"
}

variable "project" {
  description = "id of gcp project in which to install the rack"
  type        = "string"
}

variable "release" {
  description = "convox release version to install"
  default     = "master"
}

variable "region" {
  description = "gcp region in which to install the rack"
  default     = "us-east1"
}

variable "zone" {
  description = "name of gcp managed zone in which to add a cname for this rack"
  type        = "string"
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

data "google_dns_managed_zone" "zone" {
  name = var.zone
}

resource "google_dns_record_set" "system" {
  managed_zone = var.zone
  name         = "*.${local.domain}."
  rrdatas      = [module.system.endpoint]
  type         = "A"
  ttl          = 60
}

module "system" {
  #source = "github.com/convox/terraform//system/gcp"
  source = "../../../terraform/system/gcp"

  domain    = local.domain
  name      = var.name
  node_type = var.node_type
  release   = var.release

  providers = {
    google = google
  }
}

output "rack_url" {
  value = module.system.api
}
