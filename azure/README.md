# Azure

Azure deployment suite

Folder structure:

Inside workspace directory:

blkchain:

Contains the Blockchain network configuration files, scripts, node data:

All the different blockchain details are provided: Geth / Parity / Besu Clique or IBFT 2.0

This folder will be transferred to the respective VM's and then depending on the node network structure required the files will be initalised

terraform:

Contains the script files for initialising the VMs in azure.

To run this previously azure login is needed as it needs to be run on an azure account authenticated terminal.

Depending on the chosen configuration: 3 nodes / 5 nodes / 7 nodes / 11 nodes as well as Geth / Parity / Besu Clique or IBFT shell scripts are named accordingly

For eg: Inside azurelb/terraform/besuibft_3/

We need to run startterrafrom.sh for 3 nodes Besu IBFT network, it will create the necessary Azure VMs and connect them thorugh overlay network.

All the VMs will be private IPs but there will be a public IP bastion VM through which we can reach the private VMs.

The network can be orchestrated from the bastion VM.

Then from there we need to run besu_ibft_ws_deployblockchain.sh for creating the blockchain network in the respective private IP VM's and then launch the test.

Deploy of smart contract also happens when we run the script.

All the test details are stored in mongodb running in docker container which can then be collated to get the throughput
