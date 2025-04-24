# 🚀 Strapi Deployment Automation with GitHub Actions & Terraform

This project automates the deployment of a **Strapi CMS** application using **GitHub Actions**, **Docker**, and **Terraform** on an **AWS EC2 instance**.

---

## 📁 Project Overview

We have implemented a two-stage DevOps pipeline:

1. **CI Pipeline (Continuous Integration)** - Automatically builds and pushes a Docker image on every code push.
2. **CD Pipeline (Continuous Deployment)** - Manually deploys the latest Docker image to an EC2 instance using Terraform.

---

## 🔨 What We Did

### 1. Continuous Integration - Code Pipeline (`ci.yml`)
- Triggered on every push to the `main` branch.
- Built a Docker image for the Strapi application.
- Pushed the image to Docker Hub (or ECR).
- Saved the Docker image tag as an output to be used in the deployment stage.

---

### 2. Continuous Deployment - Terraform Pipeline (`terraform.yml`)
- Manually triggered using `workflow_dispatch`.
- Ran `terraform init`, `plan`, and `apply` to provision resources.
- Used GitHub Secrets to securely pass AWS credentials.
- Connected to the EC2 instance via SSH.
- Pulled the latest Docker image using the tag from the CI pipeline.
- Deployed and ran the Strapi container on the EC2 instance.

---

### 3. Infrastructure Setup
- Used **Terraform** to define and manage infrastructure:
  - Provisioned an EC2 instance with necessary permissions and security group settings.
  - Installed Docker on the EC2 instance via user data or SSH.
  - Configured SSH access to connect and deploy the container.

---

### 4. Verification
- Verified deployment by accessing Strapi via the EC2 public IP address in the browser.

---

## ✅ Final Result

- ✅ Fully automated Docker image build and push.
- ✅ Manual, controlled deployment using GitHub Actions.
- ✅ EC2-hosted, containerized Strapi app accessible via public IP.
- ✅ Secure, repeatable, and scalable infrastructure as code setup.

---

## 🔐 Notes

- AWS credentials are stored securely in GitHub Secrets.
- SSH is used to interact with the EC2 instance.
- Docker image tags ensure correct versions are deployed.

---

## 📌 Technologies Used

- **Strapi**
- **Docker**
- **GitHub Actions**
- **Terraform**
- **AWS EC2**

--- .
