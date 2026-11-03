# Flask App on AWS with Terraform

A small project that uses **Infrastructure as Code**: Terraform creates an AWS server and firewall, and installs a Python Flask app on it automatically.

## Architecture

```
You (browser) --> Internet --> Security Group (port 80 only) --> EC2 server --> Flask app (gunicorn)
                                      ^
                          All created by Terraform code
```

## What Terraform creates
- 1 Security Group (allows HTTP port 80 only; SSH is closed)
- 1 EC2 instance (Amazon Linux 2023) that installs and runs the Flask app at boot

## Tools used
Terraform, AWS (EC2, Security Group), Python, Flask, gunicorn, systemd, Git/GitHub, GitHub Actions (format and validate check).

## Project structure
```
app/            Flask app (app.py, requirements.txt)
terraform/      Terraform code (main.tf, variables.tf, outputs.tf, versions.tf, user_data.sh.tpl)
.github/        CI workflow that runs terraform fmt and validate
```

## How to run
Requirements: Terraform, AWS CLI, an AWS account with `aws configure` done.

```
cd terraform
terraform init
terraform plan
terraform apply
```
Type `yes`. After 2-3 minutes, open the `app_url` shown in the output.

## Clean up (important, avoids charges)
```
terraform destroy
```

## What I learned
- Writing infrastructure as code with Terraform (provider, data, resources, variables, outputs)
- Using `terraform init / plan / apply / destroy`
- Basics of EC2, security groups, and boot scripts (user_data)
- Running Flask in production style with gunicorn and systemd
- Running basic CI checks with GitHub Actions

## Possible improvements
- Add HTTPS with a load balancer
- Use a remote state backend (S3)
- Auto-deploy app updates from GitHub Actions
