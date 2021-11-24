<img src="images/logo.png" width="300">

# Ohmyyaml

_This repository is primarily for education purposes and shows how to scale out infrastructure in terms of workspaces and services at a large scale_

[What the heck is Terragrunt?](https://youtu.be/LuKYu9ASGyo)

A journey into "modern" DevOps deployment practices.
- Terragrunt
- Terraform
- Helm/Docker/Golang

The purpose of this repo is to show a simple app, how its packaged in Docker/Helm then deployed to Kubernetes.

<img src="images/example.png" width="700">

## Requirements

- AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
- TERRAFORM_WORKSPACE_TOKEN for TF cloud


## Terragrunt local usage

Terragrunt can operate either using a remote Git tag or with local source mode.
Local source mode is ideal for local development.


```
❯ make terragrunt-plan-infra
cd regional_configurations/eu-west-1/infrastructure_substrate && \
	trap "cd ../../../" SIGINT SIGTERM ERR EXIT && \
	terragrunt plan --terragrunt-source ../../../module_catalogue/infrastructure_substrate
WARN[0000] No double-slash (//) found in source URL /Users/alexjones/Code/ohmyyaml/module_catalogue/infrastructure_substrate. Relative paths in downloaded Terraform code may not work.
Initializing modules...
Downloading terraform-aws-modules/eks/aws 17.24.0 for eks...
- eks in .terraform/modules/eks
- eks.fargate in .terraform/modules/eks/modules/fargate
- eks.node_groups in .terraform/modules/eks/modules/node_groups

Initializing the backend...
```
