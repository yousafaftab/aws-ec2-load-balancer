# EC2 Instance with Elastic Load Balancer on AWS

A clean, fully parameterised Terraform project that provisions an **Ubuntu EC2 instance** fronted by a **Classic Elastic Load Balancer (ELB)** with health checks, cross-zone load balancing, and connection draining configured. Built as a minimal, production-friendly reference implementation for load-balanced compute on AWS.

---

## Architecture

```
  Internet
      │
      ▼
  Elastic Load Balancer
  ├── Port 80 (HTTP) listener
  ├── Health check: HTTP:8000/
  ├── Cross-zone load balancing: enabled
  ├── Connection draining: enabled (400s timeout)
  └── Deployed across 3 Availability Zones
           │
           ▼
  EC2 Instance
  ├── OS: Ubuntu 22.04 LTS (latest AMI, auto-resolved)
  ├── Type: t2.micro
  ├── Application port: 8000
  └── Deployed in Default VPC
```

---

## Features

- **Auto AMI resolution** — Always deploys the latest Ubuntu 22.04 LTS (Jammy Jellyfish) from Canonical; no manual AMI ID management
- **Elastic Load Balancer** — HTTP listener with configurable health checks, cross-zone distribution, and connection draining for zero-downtime deployments
- **Default VPC** — Uses the existing default VPC and subnets, minimising prerequisites and setup time
- **Fully parameterised** — Every aspect of the deployment (instance type, ports, AZs, thresholds, timeouts) is configurable via input variables
- **Clean outputs** — Exposes the EC2 public IP and ELB DNS name immediately after `terraform apply`

---

## Tech Stack

| Layer | Technology |
|---|---|
| Infrastructure as Code | Terraform >= 1.9.0 |
| Compute | Amazon EC2 (Ubuntu 22.04 LTS) |
| Load Balancing | AWS Elastic Load Balancer (Classic) |
| Networking | Default VPC + subnets |
| Cloud Provider | AWS (`hashicorp/aws` ~> 5.65) |

---

## Project Structure

```
simple-ec2-instance/
├── ec2.tf              # EC2 instance resource
├── elb.tf              # Elastic Load Balancer, listener, and health check
├── data.tf             # Default VPC, subnets, security group, and AMI data sources
├── variables.tf        # All input variable declarations
├── terraform.tfvars    # Default variable values
├── output.tf           # EC2 public IP and ELB DNS name
├── providers.tf        # AWS provider configuration
└── versions.tf         # Terraform and provider version constraints
```

---

## Configuration

All variables are declared in `variables.tf` with defaults set in `terraform.tfvars`.

| Variable | Default | Description |
|---|---|---|
| `aws_region` | `ap-southeast-1` | AWS deployment region |
| `ec2_name` | `yousaf-ec2` | Name tag for the EC2 instance |
| `instance_type` | `t2.micro` | EC2 instance type |
| `elb_name` | `yousaf-elb` | Name of the Elastic Load Balancer |
| `availability_zones` | `["ap-southeast-1a/b/c"]` | AZs the ELB spans |
| `instance_port` | `8000` | Port the application listens on |
| `instance_protocol` | `http` | Protocol for backend traffic |
| `lb_port` | `80` | Port the ELB listens on |
| `lb_protocol` | `http` | Protocol for client-facing traffic |
| `healthy_threshold` | `2` | Consecutive successful checks to mark instance healthy |
| `unhealthy_threshold` | `2` | Consecutive failures to mark instance unhealthy |
| `health_check_timeout` | `3` | Health check request timeout (seconds) |
| `interval` | `30` | Health check polling interval (seconds) |
| `cross_zone_load_balancing` | `true` | Distribute traffic evenly across AZs |
| `idle_timeout` | `400` | Idle connection timeout (seconds) |
| `connection_draining` | `true` | Allow in-flight requests to complete before deregistration |
| `connection_draining_timeout` | `400` | Maximum drain time (seconds) |

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.9.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS IAM permissions to create EC2 instances and Elastic Load Balancers

---

## Deployment

```bash
# Clone the repository
git clone <repo-url>
cd simple-ec2-instance

# Initialize Terraform workspace and download providers
terraform init

# Validate configuration syntax
terraform validate

# Preview resources to be created
terraform plan

# Deploy the infrastructure
terraform apply
```

---

## Outputs

After `terraform apply` completes successfully:

| Output | Description |
|---|---|
| `public_ip` | Public IP address of the EC2 instance |
| `elb_dns` | DNS name of the Elastic Load Balancer |

Access the application via the ELB DNS name:
```
http://<elb_dns>
```

---

## Cleanup

```bash
terraform destroy
```

> Confirm with `yes` when prompted. This permanently removes the EC2 instance and Elastic Load Balancer.
