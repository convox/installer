## Launching a Convox Rack on AWS with an automatically created Route53 record

### Initial Setup:
- Login to your AWS account and copy the ID (not the name) of the Route53 zone where you want the record created

### Launching your Rack with Terraform
- Follow the instructions in the [AWS Readme](../aws/README.md)
- When prompted, enter the ID (not the name) of the Route53 zone
- When your Rack creation completes you should see a `rack_url` output with the record created in your domain
- Set a local environment variable named `RACK_URL` to that value in your shell
- Follow the rest of the deployment instructions in the [AWS Readme](../aws/README.md#deploying-an-application) to deploy your first app


