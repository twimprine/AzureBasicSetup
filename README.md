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
1.	Make client specific changes to the `terraform.tfvars.json` file as needed. 

# Build and Test


# Contribute
Since this is a template - if it requires changes please open a ticket with the required changes. They will need to be applied to all child repositories as appropriate, i.e. Security fixes, etc. 

# ToDo
- Basic Fortigate integration https://github.com/fortinet/fortigate-terraform-deploy/tree/main/azure/7.0/single