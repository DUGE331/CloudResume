# Personal Portfolio: Cloud Resume Website

A fully cloud-native personal portfolio built as an advanced implementation of the Cloud Resume Challenge.

This project demonstrates serverless architecture, infrastructure as code, containerization, Kubernetes orchestration, CI/CD automation, and production deployment patterns.


🌍 Live Site: www.isaac-douglas.com


🏗 Architecture Overview

This project contains two environments:

🚀 Production Environment (AWS Serverless)

Frontend → API Gateway → Lambda → DynamoDB
↓
S3 (Static Hosting)
↓
Route 53 + SSL

Stack

AWS S3 (static hosting)

AWS Lambda (visitor counter backend)

Amazon API Gateway

Amazon DynamoDB

Route 53 (DNS)

IAM (security policies)

Terraform (Infrastructure as Code)


⚙️ Dev / Cloud-Native Environment (Container + Kubernetes)

Frontend → API → FastAPI Visitor Service → DynamoDB
↓
Docker
↓
Kubernetes (Minikube)
↓
Horizontal Pod Autoscaler

Stack

Python (FastAPI)

Docker (containerization)

Kubernetes (Minikube cluster)

Horizontal Pod Autoscaler (HPA)

GitHub Actions (CI/CD)

Terraform (infrastructure provisioning)

AWS (shared DynamoDB backend)


🔧 Key Features

✅ Infrastructure as Code (Terraform)

Entire AWS production environment provisioned via Terraform

S3 buckets, IAM roles, DynamoDB tables, API Gateway

Reproducible cloud infrastructure


✅ Serverless Backend (Production)

Lambda-based visitor counter

API Gateway integration

DynamoDB for persistent storage

Secure IAM policies

Public API consumed by frontend JavaScript


✅ Containerization (Dev)

FastAPI backend packaged in Docker

Reproducible development environment

Local testing via Docker + Minikube


✅ Kubernetes Orchestration

Deployment & Service YAML definitions

Scalable pod configuration

Secrets management for AWS credentials

Horizontal Pod Autoscaler (HPA)

Demonstrated:

Auto scaling under CPU load

Pod duplication under stress

Scale-down when idle

Self-healing when pods are manually killed


✅ CI/CD Automation

GitHub Actions pipeline:
<img width="2080" height="1397" alt="Screenshot 2026-02-28 164301" src="https://github.com/user-attachments/assets/bc4a5f93-ed32-48c3-a420-2058a0036a61" />

Automated build on push

Backend tests execution

Docker image builds
![DockerWorking2afterRefresh](https://github.com/user-attachments/assets/e7cce253-c525-46c5-9bd9-d7b730f94073)

Infrastructure validation

CloudFront invalidation (frontend updates)
<img width="1912" height="892" alt="InvalidateCloudFront-Build-Success" src="https://github.com/user-attachments/assets/d9fbea97-bc6f-4e5a-97ee-5b6cdb017d41" />


📊 Stress Testing & Observability

Load testing visitor API

Measured response times under load

Observed scaling events

Monitored pod restart counts

Verified Kubernetes self-healing behavior

<img width="2879" height="1626" alt="KuberDashScaleOut" src="https://github.com/user-attachments/assets/fbf4ce4e-6f43-4b95-9c16-230585aeae5b" />
<img width="2879" height="1589" alt="KuberDashScaleIn" src="https://github.com/user-attachments/assets/732ab389-30fb-4240-bee3-ac263fe4a84d" />
<img width="2879" height="1490" alt="KuberDashPods" src="https://github.com/user-attachments/assets/d0f73af3-3c14-4a63-a836-79cd21b68ec6" />
<img width="2856" height="1613" alt="KuberTermStressResults" src="https://github.com/user-attachments/assets/64085dab-7313-4f48-acef-a4b94a41c7a7" />

📁 Repository Structure
CloudResume/
│
├── assets/              # Static assets
├── css/                 # Frontend styles
├── js/                  # Visitor counter integration
├── backend/             # Serverless Lambda backend
├── docker/              # Docker configuration
├── kubernetes/          # Kubernetes YAML manifests
├── infrastructure/      # Terraform IaC
├── .github/workflows/   # CI/CD pipelines
├── index.html
└── README.md

🔐 Security & Networking

IAM least-privilege roles

Secure S3 bucket policies

API Gateway CORS configuration

Route 53 domain routing

SSL certificate integration

Secrets managed for Kubernetes


🎯 What This Project Demonstrates

This is not just a static website.

It demonstrates:

Cloud architecture design

Infrastructure as Code (Terraform)

Serverless backend engineering

Containerization best practices

Kubernetes orchestration

Auto scaling & resilience testing

CI/CD automation

Production-grade deployment patterns


🧠 Learning Outcomes

Designed and deployed production-ready AWS infrastructure

Implemented scalable microservice architecture

Built automated CI/CD pipelines

Applied real-world DevOps patterns

Practiced failure recovery & load testing

🔮 Future Improvements

EKS production cluster deployment

Ingress controller + ALB

Centralized logging (CloudWatch / Prometheus)

Metrics dashboard (Grafana)

Blue/Green deployment strategy

Authenticated admin dashboard for analytics


🏆 Why This Stands Out

Most Cloud Resume projects stop at serverless.

This version expands into:

Kubernetes

Auto scaling

Container orchestration

Stress testing

CI/CD pipelines

Production deployment patterns

This demonstrates real-world DevOps capability beyond a tutorial implementation.

Expand API integrations for dynamic project data.
