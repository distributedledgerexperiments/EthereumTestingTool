#!/bin/sh

./../terralibrary/terraformbin/terraform init

./../terralibrary/terraformbin/terraform plan

./../terralibrary/terraformbin/terraform apply

az vm list-ip-addresses --ids $(az vm list --resource-group geth15-rg --query "[].id" --output tsv)
