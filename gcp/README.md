## Launching a Convox Rack on GCP and deploying and application

- Install the latest Convox CLI for your operating system using the instructions found here: https://docs.convox.com/introduction/installation
- Run `convox update`
- Create a [convox.yml](https://docs.convox.com/application/convox-yml) file to describe your application
- Sign up for GCP if you have not already (https://console.cloud.google.com)
- In the GCP dashboard create a new project and switch to it, note the ID of the project
- Go to https://console.cloud.google.com/apis/credentials/serviceaccountkey
- Ensure you have your new project selected from the dropdown
- Select "new service account"
- Give it a name like "terraform"
- Give it the project owner role
- Select key type JSON
- Click create
- Download the credential file
- Copy the credential file to ~/.config/gcloud/terraform.json
- Clone https://github.com/convox-examples/terraform into a local directory and change to that directory
- Go into the gcp subdirectory
- Run `terraform init`
- Run `terraform apply`
- When prompted enter the name of a domain that you have DNS control over
  - for example: `convox.mydomain.com`
- When prompted enter the ID (not the name) of the GCP project your created at the beginning of this process
- Follow the terraform prompts 
- When terraform apply completes you should see an output  named rack_url. Set a local environment variable named RACK_URL to that value in your shell
- Set the wildcard `*.` A record for the domain entered previously to the value of the endpoint output
  - for example: `*.convox.mydomain.com A [OUTPUT_IP_ADDRESS]`
- Run `convox rack` and verify your output looks something like
```
Name      convox
Provider  gcp
Status    running
Version   master 
```

- If you don't see this output or you see an error verify that your domain is resolving correctly
- If everything looks good change to the directory containing the application you want to deploy
- Run `convox apps create --wait`
- Once complete run `convox deploy --wait`
- Once complete run `convox services` to find the URL(s) of your running service(s)

