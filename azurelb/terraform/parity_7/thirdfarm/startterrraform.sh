#!/bin/sh

./terraformbin/terraform init

./terraformbin/terraform plan

./terraformbin/terraform apply

az vm list-ip-addresses --ids $(az vm list --resource-group renaultnissan-rg --query "[].id" --output tsv)
