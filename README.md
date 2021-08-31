## Prerequisits:
1. azure-cli installed on the machine (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
2. An Azure subscription in which the resources will be created

## Setup:
1. Install terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli) 
2. Login to the desired azure subscription (using 'az login' cli command)

## Run
1. Create a new directory parallel to the 'base' directory and copy the content of the 'base' directory into it.
2. cd into the newly created folder
3. Run the following commands:
3.1  terraform init
3.2  terraform get
3.3 terraform plan/apply
