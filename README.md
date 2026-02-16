# 🚀 Strapi Deployment Automation Project
Nithin Settibathula

## 📝 Project Overview
This repository contains the complete automation for deploying a **Strapi CMS** application to **AWS EC2**. I have implemented a full CI/CD lifecycle using **Terraform** for Infrastructure as Code and **GitHub Actions** for automation.

---

## 🏗 Architecture
The deployment follows a professional DevOps workflow:
1. **Source Code:** GitHub Repository
2. **CI:** GitHub Actions builds Docker Image and pushes to **Docker Hub**.
3. **IaC:** Terraform provisions AWS resources (EC2, Security Groups).
4. **CD:** Terraform pulls the latest Docker image onto EC2 via `user_data`.

[Image of a DevOps CI/CD pipeline architecture for AWS and Docker]

---

## 🛠 Features Implemented
* **Dockerization:** Multi-stage Docker build for Strapi.
* **Terraform State:** Used **S3 Backend** for secure state management.
* **Automation:** * `ci.yml`: Automated builds on every push.
    * `terraform.yml`: Manual deployment trigger (Workflow Dispatch).
* **Security:** Configured automated AWS Security Groups for Ports 80 and 22.

---

## 🌐 Deployment Details
| Resource | Details |
| :--- | :--- |
| **Public IP** | `98.93.194.95` |
| **Application URL** | [http://98.93.194.95](http://98.93.194.95) |
| **Instance Type** | `t2.micro` |
| **Region** | `us-east-1` |

---

## 🚀 How I Completed This Task
### 1. CI/CD - Code Pipeline
Created a workflow to build the Docker image, tag it with a unique GitHub SHA, and push it to Docker Hub
