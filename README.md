# AWS Event-Driven Architecture

## Event-Driven Architecture on AWS using EKS, KEDA, and GitLab CI

This repository showcases a cloud-native event-driven architecture on AWS using **Amazon SQS**, **Amazon EKS**, **KEDA** for autoscaling, and **GitLab CI/CD** for application deployment. The infrastructure is provisioned entirely using **Terraform**, with Kubernetes workloads configured through manifest files.

---

## Architecture Overview


![aws event-drvien-Diagram](https://github.com/user-attachments/assets/7c7a1ed9-0347-479e-a99d-ab7a4ec22fde)



- **Terraform** provisions VPC, EKS, IAM, and SQS.
- **GitLab CI/CD** pipeline deploys Kubernetes manifests.
- **KEDA** dynamically scales pods based on SQS queue depth.

---

## Sample Folder Structure for the Architecture 

```bash
aws-event-driven-architecture/
├── terraform/                  # Infrastructure-as-Code (Terraform modules)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── eks.tf
│   ├── iam.tf
│   └── sqs.tf
│
├── k8s/                        # Kubernetes manifests
│   ├── deployment.yaml
│   ├── scaledobject.yaml
│
├── Dockerfile                 # Optional: sample app Dockerfile
├── .gitlab-ci.yml             # GitLab CI pipeline for EKS deployment

```
## Key Technologies

AWS SQS – Event queue system

Amazon EKS – Kubernetes cluster for consumer pods

KEDA – Event-driven autoscaler for Kubernetes

Terraform – IaC to provision AWS resources

GitLab CI/CD – Pipeline to deploy Kubernetes manifests

Prometheus + Grafana – Observability and metrics

CloudWatch – Queue depth and pod logs

## How it Works
A Producer (Lambda/API, Kafka or any other event platforms) sends messages to Amazon SQS.

KEDA monitors SQS queue depth.

When messages exceed a defined threshold, KEDA scales up EKS worker pods.

Worker pods consume messages, process them, and scale down when idle.

Observability stack ensures real-time metrics and alerting.


## Terraform Infra SetUp
```bash 
cd terraform
terraform init
terraform plan
terraform apply

```

## ☸️ Kubernetes App Deployment

```bash
 
kubectl apply -f k8s/
```

```bash 
deploy:
  stage: deploy
  image: bitnami/kubectl:latest
  script:
    - aws eks update-kubeconfig --region us-east-1 --name event-cluster
    - kubectl apply -f k8s/
```


## 📈 Monitoring and Observability
Amazon CloudWatch – Monitors queue metrics

Prometheus – Scrapes metrics from KEDA & pods

Grafana – Visual dashboards for EKS and application metrics


## 🔐 Security
IAM Roles for Service Accounts (IRSA) – Secure pod-level AWS access

Private subnets – For all compute workloads

SQS encryption – Enabled via AWS KM


## 🧭 Future Improvements
Add Dead Letter Queue (DLQ) for failed messages

Integrate ArgoCD for GitOps-style continuous delivery

Replace or use SQS with Kinesis for real-time streaming analytics

Use EKS Fargate for finer-grained pod billing

Integrate runtime security scanning tools like Falco or Prisma Cloud
