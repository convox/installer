## Launching a Convox Rack on AWS and deploying an application

- Install the latest Convox CLI for your operating system using the instructions found here: https://docs.convox.com/introduction/installation
- Run `convox update`
- Create a [convox.yml](https://docs.convox.com/application/convox-yml) file to describe your application
- Sign up for AWS if you have not already (https://signin.aws.amazon.com/)
- Ensure that your AWS credentials are set on your local machine.  We like using [aws-vault](https://github.com/99designs/aws-vault) but having your Access Key ID and Secret Access Key set as env vars should do fine as well:
    ```
    $ export AWS_ACCESS_KEY_ID="anaccesskey"
    $ export AWS_SECRET_ACCESS_KEY="asecretkey"
    $ export AWS_DEFAULT_REGION="us-west-2"
    ```
- If you don't already have these values, you can obtain them from the IAM service dashboard within AWS.
- Clone https://github.com/convox-examples/terraform into a local directory and change to that directory
- Go into the `aws` subdirectory
- Run `terraform init`
- Run `terraform apply`
- When prompted enter the name of a domain that you have DNS control over
  - for example: `convox.mydomain.com`
- Follow the terraform prompts 
- When `terraform apply` completes you should see an output named `rack_url`. Set a local environment variable named `RACK_URL` to that value in your shell
  - `$ export RACK_URL=https://convox:password@api.convox.mydomain.com=`
- Set the wildcard `*.` A record for the domain entered previously to the value of the endpoint output
  - for example: `*.convox.mydomain.com A [OUTPUT_IP_ADDRESS]`
- Run `convox rack` and verify your output looks something like
```
Name      convox
Provider  aws
Status    running
Version   master 
```

- If you don't see this output or you see an error verify that your domain is resolving correctly
- If everything looks good change to the directory containing the application you want to deploy
- Run `convox apps create --wait`
- Once complete run `convox deploy --wait`
- Once complete run `convox services` to find the URL(s) of your running service(s)

