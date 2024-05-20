# FastAPI and MySQL Application Deployment

This guide provides the steps to deploy a FastAPI and MySQL application using Terraform and Ansible.

## Prerequisites

1. **Terraform**: Install Terraform by following the instructions [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).
2. **Ansible**: Install Ansible by following the instructions [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
3. **AWS CLI**: Install AWS CLI by following the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
4. **AWS Credentials**: Configure your AWS credentials using `aws configure`.

## Create an SSH Key Pair in AWS

First, create an SSH key pair in AWS. This key pair will be used to access your EC2 instances.

```sh
aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > ~/.ssh/MyKeyPair.pem
chmod 400 ~/.ssh/MyKeyPair.pem
```

## Installation Steps
1. Clone the Repository
Clone the repository to your local machine:
```sh
git clone https://github.com/Franky-Lim24/heap-workshop.git
cd heap-workshop
```

2. Deploy Infrastructure with Terraform
Navigate to the Terraform directory and initialize Terraform:
```sh
cd terraform
terraform init
```

Apply the Terraform configuration to deploy the infrastructure:
```sh
terraform apply
```

3. Note the Outputs
After Terraform has completed, it will output the following information:
- Public IP address
- DNS
- Instance ID
  
4. Configure Ansible Inventory
Navigate to the Ansible directory:
```sh
cd ../ansible
```
Edit the inventory.ini file and replace the placeholder with the actual IP address output by Terraform:
```sh
[web]
<public_ip> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/MyKeyPair.pem
```

5. Deploy the Backend Application with Ansible
Run the Ansible playbook to configure the server and deploy the application:
```sh
ansible-playbook -i inventory.ini deploy.yml
```
