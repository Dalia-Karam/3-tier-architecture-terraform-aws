# 🌐 3-Tier Architecture Deployment on AWS

## 📘 Overview

This project implements a scalable and highly available **3-Tier Architecture** on Amazon Web Services (AWS), following best practices for modularization, isolation, high availability, and automation using **Terraform**.

It includes:

- **Tier 1 (Web Layer):** Public-facing EC2 instances behind an internet-facing Load Balancer.
- **Tier 2 (Application Layer):** Private EC2 instances behind an internal Load Balancer.
- **Tier 3 (Database Layer):** A highly available Amazon RDS MySQL instance with Multi-AZ enabled.

Each layer is distributed across **two Availability Zones** to ensure **fault tolerance and high availability**.

---

## 🧱 What is a 3-Tier Architecture?

A **3-tier architecture** is a design pattern that separates an application into three distinct layers:

- **Presentation Tier** – The frontend (user interface).
- **Application Tier** – The backend logic and API processing.
- **Data Tier** – The storage layer, typically databases.

✅ **Benefits**:
- Enhanced security through tier isolation  
- Better scalability and maintainability  
- Improved resiliency and fault tolerance

---

## Architecture Diagram
![3tier-architecture](https://github.com/user-attachments/assets/73dcd3ff-55f1-4272-be8c-8cec2100f7e2)

---

## 🛠️ Architecture Components

### 🔹 Tier 1 – Web Layer (Public Subnet)
- **Internet-Facing ALB**: Accepts external traffic from the internet.
- **Launch Template + ASG**: Manages public EC2 instances based on demand.
- **Target Group**: Registers EC2 instances in public subnets.
- **EC2 Web Servers**: Host the frontend (e.g., NGINX, Apache).

### 🔸 Tier 2 – Application Layer (Private Subnet)
- **Internal ALB**: Accepts traffic from the web tier.
- **Launch Template + ASG**: Manages private EC2 instances hosting business logic.
- **Target Group**: Routes requests to backend EC2 instances.
- **EC2 App Servers**: Run backend services/APIs.

### 🔻 Tier 3 – Database Layer (Private Subnet)
- **Amazon RDS (MySQL)**:
  - Deployed in **private subnets**
  - **Multi-AZ** enabled for automatic failover
  - Highly available and managed by AWS
- **RDS Subnet Group**: Ensures proper placement across AZs
- **Read Replica**: Enhances performance and resiliency

---

## 🏗️ High Availability & Resilience

- **2 Availability Zones**: All layers are distributed across AZs for fault tolerance.
- **Auto Scaling Groups**: Dynamically adjust the number of instances based on load.
- **ALBs**: Ensure seamless routing and zero-downtime deployments.
- **RDS Multi-AZ**: Automatically promotes standby DB in case of failure.

---

## 🔐 Security Best Practices

- **Public Subnets**: Only accessible via HTTP/HTTPS.
- **Private Subnets**: No direct internet access.
- **Security Groups**:
  - Web Tier can talk to App Tier only
  - App Tier can talk to RDS only
  - No direct cross-tier or internet access without explicit rules

---

## 🚀 Deployment Instructions

> Make sure you have [Terraform](https://www.terraform.io/downloads) installed and configured with AWS credentials.

1. **Configure remote backend** in `backend.tf` using your S3 bucket.

2. **Set variable values** in `terraform.tfvars` (or pass via CLI).

3. **Initialize Terraform**:
```bash
terraform init
```

4. **Plan Infrastructure**:
```bash
terraform plan
```

5. **Apply Configuration**:
```bash
terraform apply
```
