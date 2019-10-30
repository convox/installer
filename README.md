# convox/terraform

- Website: https://convox.com
- Forum: [https://community.convox.com/](https://community.convox.com/)

Templates for standing up a [Convox Rack](https://github.com/convox/convox) using Terraform.

## Usage

Go into the appropriate subdirectory and follow the instructions in the readme

* [aws](/aws) Standard template for creating a Rack on AWS/EKS
* [gcp](/gcp) Standard template for creating a Rack on GCP/GKE
* [aws-route53](/aws-route53) Template for creating a Rack and registering it with Route 53
* [gcp-cloud-dns](/gcp-cloud-dns) Template for creating a Rack and registering it with GCP Cloud DNS

## Getting Started
[Convox Rack](https://github.com/convox/convox) is an open source PaaS that installs an API inside of a Kubernetes Cluster which can then be controlled via the [Convox CLI](https://docs.convox.com/introduction/installation). With the Convox CLI you can easily deploy and manage any containerized app with a handful of simple [commands](https://docs.convox.com/reference/cli-commands).

For more information you can check out the following resources:

- [Convox Getting Started Guide](https://docs.convox.com/introduction/getting-started)
- [Convox FAQ](https://docs.convox.com/introduction/faq)


## Features

Key features include

* [Build and release management](https://docs.convox.com/deployment/builds)
* [Automated Rollbacks](https://docs.convox.com/deployment/rolling-back)
* [Resource Management](https://docs.convox.com/use-cases/resources) \(Postgres/Redis/etc..\)
* [Secrets Management](https://docs.convox.com/application/environment)
* [Autoscaling](https://docs.convox.com/deployment/scaling)
* [Timers/Cron Jobs](https://docs.convox.com/application/timers)
* [One-off-Commands](https://docs.convox.com/management/one-off-commands)

## License

Apache 2.0


