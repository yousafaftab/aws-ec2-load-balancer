# AWS Infrastructure with Terraform

This Terraform project provisions AWS infrastructure, including an EC2 instance and an Elastic Load Balancer (ELB). The configuration utilizes AWS data sources and variables to allow customization and flexibility.

## Table of Contents

1. [Overview](#overview)
2. [Files Overview](#files-overview)
3. [Prerequisites](#prerequisites)
4. [Setup](#setup)
5. [Deployment](#deployment)
6. [Outputs](#outputs)
7. [Cleanup](#cleanup)
8. [Code Review](#code-review)

## Overview

This Terraform configuration sets up a basic infrastructure on AWS, consisting of:
- An EC2 instance running on Amazon Linux AMI.
- An Elastic Load Balancer (ELB) configured to distribute traffic across instances.
- Uses default VPC, subnets, and security groups for simplicity.

## Files Overview

1. **data.tf**: 
   - Fetches AWS data sources like default VPC, subnets, security group, and AMI.
   - Ensures that resources are deployed within the existing AWS infrastructure.

2. **ec2.tf**: 
   - Defines an EC2 instance using the fetched AMI and subnet details.
   - Allows customization of the instance type and name via variables.

3. **elb.tf**: 
   - Creates an Elastic Load Balancer (ELB) in the specified availability zones.
   - Configures listeners, health checks, and load balancing settings.
   - Associates the ELB with the EC2 instance.

4. **output.tf**: 
   - Specifies output values for the public IP of the EC2 instance and the DNS name of the ELB.

5. **provider.tf**: 
   - Configures the AWS provider with the specified region and AWS profile.

6. **variables.tf**: 
   - Defines input variables for customizing resources like EC2 instance type, ELB settings, and other configurations.

7. **versions.tf**: 
   - Specifies the required versions of Terraform and the AWS provider.

8. **terraform.tfvars**: 
   - Contains default values for input variables to simplify deployment.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.9.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate permissions.
- AWS account with access to create VPCs, EC2 instances, and ELBs.

## Setup

Before deploying the resources, ensure you have the following configured:

1. **AWS Credentials**: Configure your AWS credentials using the AWS CLI or environment variables.

2. **Terraform Installation**: Install Terraform using the instructions on the [official Terraform website](https://www.terraform.io/downloads.html).

## Deployment

To deploy the resources defined in this Terraform project, follow these steps:

1. **Initialize the Terraform workspace:**

   ```bash
   terraform init

2. **Validate the Terraform code:**
    ```bash
    terraform validate

3. **Plan the deployment to see the resources that will be created:**
    
    ```bash
    terraform plan

4. **Apply the configuration to deploy the resources:**    

    ```bash
    terraform apply

## Cleanup

1. **Destroy the infrastructure:**    
    
    ```bash
    terraform destroy

Confirm the destruction by typing yes when prompted. This will remove all the resources created by the Terraform configuration.