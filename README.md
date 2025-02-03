# Introduction 
This is the standard template for Azure infrastructure to be created. This will create the standard resources with tags and appropriate security. 

# Getting Started
1. Ensure you have Git installed - https://git-scm.com/downloads/win
1.	Installation process
    Since this is a template clone this repository to your local system. This is your reference code - Changes should not be made here. 
1.	Create new directory to house client/project files ("../ClientName"), copy the reference files into the new directory and initialize the new repository. 
    ```
    cd ..
    mkdir ClientName
    robocopy `.\Azure Standard Framework\` ClientName /E /Z /ETA 
    cd ClientName
    git init
    ```  
    `This really should be a fork but I'm not sure how to do this in TFS yet`
1.	Copy the `terraform.tfvars.json.sample` file and remove the `sample` extension. Make client specific changes to the `terraform.tfvars.json` file as needed. 

# Build and Test
1. Install the Azure CLI - https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
1. Login with Azure ```az login```
1. Retrieve your subscription-id ```az account show --query id --output tsv```
1. If it's not already created - create the 'Service Principal' for Terraform 
    ```
    az ad sp create-for-rbac --name "terraform-sp" --role Contributor --scopes /subscriptions/<your_subscription_id>
    ```

## Networking

### Subnetting
The subnets are defined as 24-bit subnets from a larger 16-bit subnet defined in the variables files. They are defined here as reference

- x.x.0.0/24 - External Network
- x.x.1.0/24 - Internal Server Network
- x.x.2.0/24 - VPN Network

#### I'm generally not a fan of just using large networks, however cloud providers generally don't like weird numbers of bit for the subnet masks hence why we are using 24-bits for networks that generally don't need them. 


# Contribute
Since this is a template - if it requires changes please open a ticket with the required changes. They will need to be applied to all child repositories as appropriate, i.e. Security fixes, etc. 

# ToDo
- ~~Basic Fortigate integration https://github.com/fortinet/fortigate-terraform-deploy/tree/main/azure/7.0/single~~
- Using Azure firewall and VPN 


