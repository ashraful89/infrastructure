# UCAN Infrastructure️

UCAN's infrastructure runs on Azure and is provisioned with Terraform.

# Getting started

## Prerequisites:

- [Mac]
  - Install [Homebrew](https://brew.sh) on your [Mac](https://www.apple.com/mac/)
  - Clone this repository
  - run `brew bundle`
- [Windows] 
  - Install https://chocolatey.org/
  - `choco install azure-cli`
  - `choco install make`
  - `choco install terraform`
- Make sure to have access to Microsoft Azure Portal `https://portal.azure.com/` and a valid subscription
  and resource group
- run `az login` and log into your account in the browser window az (`login --tenant <TENANT-ID>`) 
  - Tenant ID can be found in Azure `Directories + subscriptions` or in `environments/ops/locals.tf`
- setup terraform cloud, an admin will need to add you as a user here `https://app.terraform.io/app/U-Can` 
  - Then you can run `terraform login` from the infra route.
- run `tfenv install` inside the infrastructure folder
- Copy the .env file from 1Password and add a local `.env` file at the route of infra.

## Provision manually

### First time setup
- Storage accounts are setup using the `Make` file
- `Make` file has commands to setup storage accounts for ops, staging and production. run them respectvely
  - for staging for eg:
    - run make `setup-staging-state-storage`
- Create service principal client secret in azure: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
  - Then update the .env file and terraform cloud account. 

### Preparations

- Make sure that you load the environment variables in the `.env` file. This
  could be acomplished by using an
  [appropriate plugin for your shell](https://github.com/johnhamelink/env-zsh).

Provision to staging:

```
cd environments/staging
terraform init
terraform plan
terraform apply
```

## Provision with Makefile

Run this command:

```
make apply-staging
```

Make will load the `.env` file and execute the appropriate tasks.

## Azure AD b2c setup 
- [Instructions](README_AD_B2C.md)
![](./bin/Azure%20serverless%20web%20app%20UCAN.png)


