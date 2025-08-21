# mini-project4-terraform-scripts
# Terraform AWS Infrastructure Setup

This repository contains **Terraform scripts** to automate the creation of a complete AWS infrastructure.  
The goal is to provision a secure, scalable, and production-ready environment with just a few commands.

---

## 🚀 What This Project Does
The Terraform scripts in this repository will create the following AWS resources:

- **VPC** – A custom Virtual Private Cloud to isolate your resources securely.  
- **Subnets** – Divided networks inside the VPC (public & private) to organize and control resource placement.  
- **Route Tables** – Rules that decide how traffic flows within the VPC and to/from the internet.  
- **Internet Gateway** – Allows instances in public subnets to connect to the internet.  
- **Elastic IP** – A static IP address that remains constant even if the instance restarts.  
- **NAT Gateway** – Enables private subnet instances to access the internet (e.g., for updates) without being exposed.  
- **RDS** – A managed Relational Database Service (e.g., MySQL/PostgreSQL) deployed inside the VPC for secure data storage.  
- **EC2 Instance** – A virtual server launched in the created VPC and subnet, useful for applications or testing.  
- **Key Pair** – A secure SSH key pair for connecting to EC2 instances.  
- **Security Group** – A virtual firewall controlling inbound/outbound traffic for resources. Configured to allow SSH and HTTP.

---

## 📖 AWS Services Explained

- **VPC (Virtual Private Cloud):** A logically isolated network within AWS where you can launch resources with full control over IP ranges, subnets, and security.  
- **Subnets:** Smaller subdivisions of a VPC. Public subnets expose resources to the internet, while private ones keep them internal.  
- **Route Tables:** Collections of rules (routes) that define where network traffic from subnets is directed.  
- **Internet Gateway:** Acts like a bridge between your VPC and the internet, required for public-facing services.  
- **Elastic IP (EIP):** A static public IPv4 address you can associate with an instance or NAT gateway, ensuring consistency.  
- **NAT Gateway:** Allows instances in private subnets to download updates or connect out, while keeping them unreachable from the public internet.  
- **RDS (Relational Database Service):** A managed database service that automates backups, scaling, and patching, letting you focus on using your data instead of managing infrastructure.  
- **EC2 (Elastic Compute Cloud):** A scalable compute service that provides virtual servers for hosting applications.  
- **Key Pair:** Consists of a public and private key for secure SSH access to your EC2 instances.  
- **Security Group:** Acts like a firewall that controls traffic at the instance level, deciding what gets in and out.

---

## ⚙️ How to Use This Project

### 1. AWS Setup
- Create an **IAM User** with `AdministratorAccess`.
- Generate an **Access Key** and **Secret Key** for this user.

### 2. Configure AWS CLI
Open Git Bash (or terminal) and run:
```bash
aws configure

# Initialize Terraform and install dependencies
terraform init

# Check and format all scripts
terraform fmt

# Preview execution plan
terraform plan

# Apply the scripts to create AWS resources
terraform apply

# Destroy all created resources
terraform destroy
