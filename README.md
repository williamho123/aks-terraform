# AKS Terraform

Terraform for creating an AKS cluster, with the HTTP application routing add-on enabled for automatically configuring ingress endpoints that are synced with an external DNS zone.

## Deployment

The Terraform deployment of the AKS cluster happens via Github Actions. Once changes to the intended cluster state are pushed to `main`, the deployment automatically kicks off and the cluster is created and/or updated to the desired state.

The Terraform state file is stored in a remote Azure blob storage account that the Action references.

## Running Locally

Couple of pre-requisite steps need to be performed before being able to run the Terraform locally. There are 2 ways of doing this:

1. Using a personal user account:
```bash
# Login to the Azure CLI
$ az login
$ az account set -s {subscription_id}

# Run the Terraform
$ terraform init
$ terraform apply
```

2. Using a service principal and storage account access key
```bash
# Set the service principal details
$ export ARM_CLIENT_ID={SP_application_id}
$ export ARM_CLIENT_SECRET={SP_client_secret}
$ export ARM_SUBSCRIPTION_ID={SP_subscription_id}
$ export ARM_TENANT_ID={SP_tenant_id}

# Set the storage account access key where the state file is located
$ export ARM_ACCESS_KEY={SA_access_key}

# Run the Terraform
$ terraform init
$ terraform apply
```
