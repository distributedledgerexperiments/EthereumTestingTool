#!/bin/sh

./terraformbin/terraform destroy

rm -rf terraform.tfstate

rm -rf terraform.tfstate.backup
