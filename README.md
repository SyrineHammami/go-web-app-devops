# Go Web App – DevOps Practice Project

This project was created by Syrine Hammami for **learning and practice purposes**, focusing on building a complete DevOps pipeline around a basic Go web application originally developed by [Abhishek Veeramalla](https://github.com/AbhishekVeeramalla).

---

## 🚀 What’s Included

- 🐹 **Go** application
- 🐳 **Docker** (multi-stage build using distroless base image)
- ☸️ **Kubernetes** (Deployment, Service, Ingress resources)
- 📦 **Helm** chart for templating Kubernetes manifests
- ⚙️ **Terraform** to provision an **EKS cluster** on AWS
- 🔁 **CI/CD with GitHub Actions**
  - Build, test, static analysis
  - Docker image build & push
  - Helm chart update
- 🎯 **CD with Argo CD** (automated deployment to cluster)
- ☁️ **AWS EKS** for hosting the application

---

## 🔧 DevOps Workflow Summary

1. **Run & build the Go app locally**
2. **Containerize** it securely with a minimal Docker image
3. **Provision an EKS cluster** using Terraform
4. **Deploy** to a Kubernetes cluster using manifests and Helm
5. **Automate CI/CD** with GitHub Actions and Argo CD
6. **Expose the app** through Ingress with hostname-based routing
7. **Host the app** on AWS using an EKS cluster

---

