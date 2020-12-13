#!/bin/sh

# Create for bastion host VM.
ssh-keygen -t rsa -b 4096 -C "renault" -f ./id_rsa_azurebstn -N ''

# Create for worker host VM.
ssh-keygen -t rsa -b 4096 -C "renault" -f ./id_rsa_azurewrkr -N ''

# Get the SSH public key value for bastion host.
cat ./id_rsa_azurebstn.pub

# Get the SSH public key value for worker host.
cat ./id_rsa_azurewrkr.pub
