variable "credentials" {
  description = "path to credentials, create at https://console.cloud.google.com/apis/credentials/serviceaccountkey"
  default     = "~/.config/gcloud/terraform.json"
}

variable "domain" {
  description = "rack base domain, you will need to point *.domain at the output named endpoint"
  type        = "string"
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
  description = "gcp project in which to install the rack"
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

provider "google" {
  version = "~> 2.12"

  credentials = pathexpand(var.credentials)
  project     = var.project
  region      = var.region
}

module "system" {
  source = "github.com/convox/terraform//system/gcp"

  domain    = var.domain
  name      = var.name
  node_type = var.node_type
  release   = var.release

  providers = {
    google = google
  }
}

output "endpoint" {
  value = module.system.endpoint
}

output "rack_url" {
  value = module.system.api
}
