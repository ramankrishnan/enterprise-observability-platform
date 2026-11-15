# Enterprise Cloud Infrastructure & Observability Platform

A hands-on Cloud and DevOps engineering portfolio project focused on Azure infrastructure automation, Terraform, Linux administration, CI/CD, containerization, monitoring, alerting, security, and troubleshooting.

The project demonstrates how cloud infrastructure and monitoring systems can be designed, automated, deployed, validated, and maintained using industry-standard DevOps tools.

## Project Goals

- Build reusable Azure infrastructure using Terraform.
- Organize infrastructure into DEV, TEST, QA, STAGING, and PROD environments.
- Implement Infrastructure as Code (IaC) using reusable Terraform modules.
- Automate Terraform validation through GitHub Actions.
- Deploy and manage Ubuntu Linux virtual machines.
- Install and manage Docker and containerized services.
- Implement Prometheus metrics collection.
- Create Grafana dashboards for infrastructure monitoring.
- Configure Alertmanager for alert management.
- Practice Bash and Python automation.
- Implement security-conscious infrastructure configurations.
- Perform troubleshooting, incident investigation, and root-cause analysis.
- Apply cost-aware cloud infrastructure practices.

## Architecture Overview

```text
                 Developer
                     |
                     v
              GitHub Repository
                     |
                     v
             Pull Request / Review
                     |
                     v
               GitHub Actions
                     |
                     v
         Terraform Format / Validate
                     |
                     v
              Microsoft Azure
                     |
                     v
              Ubuntu Linux VM
                     |
                     v
                  Docker
                     |
          +----------+----------+
          |          |          |
          v          v          v
      Prometheus  Grafana  Alertmanager
          |
          v
     Node Exporter
          |
          v
   Infrastructure Metrics
```

## Technology Stack

| Category | Technology |
|---|---|
| Cloud Platform | Microsoft Azure |
| Infrastructure as Code | Terraform |
| Version Control | Git and GitHub |
| CI/CD | GitHub Actions |
| Operating System | Ubuntu Linux |
| Containers | Docker |
| Container Orchestration | Kubernetes / AKS |
| Monitoring | Prometheus |
| Metrics Exporter | Node Exporter |
| Visualization | Grafana |
| Alert Management | Alertmanager |
| Logging | Loki |
| Configuration Management | Ansible |
| Automation | Bash and Python |
| Documentation | Markdown |

## Repository Structure

```text
enterprise-observability-platform/
|
+-- terraform/
|   |
|   +-- bootstrap/
|   |
|   +-- environments/
|   |   +-- dev/
|   |   +-- test/
|   |   +-- qa/
|   |   +-- staging/
|   |   +-- prod/
|   |
|   +-- modules/
|       +-- resource-group/
|       +-- networking/
|       +-- monitoring-network/
|       +-- linux-vm/
|
+-- monitoring/
|   |
|   +-- alertmanager/
|   |   +-- alertmanager.yml
|   |
|   +-- grafana/
|   |   +-- dashboards/
|   |   |   +-- linux-dashboard.json
|   |   |
|   |   +-- provisioning/
|   |       +-- dashboards/
|   |       +-- datasources/
|   |
|   +-- prometheus/
|   |   +-- prometheus.yml
|   |   +-- rules/
|   |       +-- node-alerts.yml
|   |
|   +-- docker-compose.yml
|   +-- .env.example
|
+-- scripts/
|   +-- audit-infrastructure.sh
|   +-- deploy-terraform-dev.sh
|   +-- install-docker.sh
|   +-- upgrade-dashboard.py
|   +-- upgrade-dashboard-v2.py
|
+-- docs/
|
+-- .github/
|
+-- .gitignore
+-- README.md
+-- LICENSE
```

## Azure Infrastructure

The project uses Microsoft Azure as its cloud platform.

The Terraform configuration is organized into separate environments to support environment-specific infrastructure management.

| Environment | Purpose |
|---|---|
| DEV | Development and infrastructure testing |
| TEST | Application and infrastructure testing |
| QA | Quality assurance |
| STAGING | Pre-production validation |
| PROD | Production environment design |

The initial implementation focuses on the DEV environment. The remaining environments are part of the planned project scope and will be implemented progressively.

### Infrastructure Components

- Azure Resource Groups
- Azure Virtual Networks
- Network Security Groups
- Application and monitoring subnets
- Linux Virtual Machines
- Static Public IP configuration
- SSH-based authentication
- Terraform remote state management

## Terraform Modules

Reusable Terraform modules help maintain consistent infrastructure configurations.

Current module scope:

- Resource Group
- Networking
- Monitoring Network
- Linux Virtual Machine

The DEV environment uses these modules to provision and manage its infrastructure.

## Monitoring and Observability

The monitoring stack is deployed using Docker Compose on an Ubuntu Linux virtual machine.

### Prometheus

Prometheus collects and stores infrastructure metrics.

### Node Exporter

Node Exporter exposes Linux system metrics, including:

- CPU utilization
- Memory utilization
- Disk usage
- Network traffic
- System uptime

### Grafana

Grafana visualizes the collected metrics through a Linux infrastructure dashboard.

The dashboard contains:

- CPU usage
- Memory usage
- Root disk usage
- System uptime
- Network traffic
- Prometheus health
- Node Exporter health
- Firing alerts
- CPU and memory thresholds

### Alertmanager

Alertmanager handles alerts generated by Prometheus.

Current alert rule examples:

- InstanceDown
- HighCPUUsage
- HighMemoryUsage
- LowDiskSpace

Notification integrations can be added as the project evolves.

## Automation Scripts

The `scripts/` directory contains automation utilities.

| Script | Purpose |
|---|---|
| audit-infrastructure.sh | Audits infrastructure information |
| deploy-terraform-dev.sh | Supports DEV Terraform deployment workflow |
| install-docker.sh | Installs Docker |
| upgrade-dashboard.py | Adds dashboard KPI panels |
| upgrade-dashboard-v2.py | Upgrades dashboard status panels with backup handling |

Review scripts and their prerequisites before executing them. Infrastructure-changing operations should be reviewed before approval.

## Security Practices

Security is an important part of this project.

- SSH key-based authentication.
- No SSH private keys in Git.
- Sensitive environment files excluded from Git.
- Terraform state files excluded from Git.
- Environment-specific configuration.
- Restricted monitoring service port exposure.
- Network Security Group rules.
- GitHub repository secret protection.
- No hard-coded credentials in source code.

Create a local `.env` file from `.env.example` and provide your own credentials. Never commit the actual `.env` file.

## Validation and Quality Checks

The project uses validation checks before publishing code:

- Bash syntax validation using `bash -n`.
- Python syntax validation using Python AST parsing.
- Terraform formatting using `terraform fmt`.
- Terraform configuration validation using `terraform validate`.
- Git whitespace checks using `git diff --check`.
- Credential pattern scanning.
- JSON validation for Grafana dashboards.

## Learning and Implementation Roadmap

- [x] Azure Terraform foundation
- [x] Reusable resource group and networking modules
- [x] Monitoring network and Linux VM module implementation
- [x] Docker installation and monitoring stack setup
- [x] Prometheus configuration and alert rules
- [x] Grafana dashboard creation
- [x] Alertmanager configuration
- [x] Monitoring source synchronization into the repository
- [x] Automation scripts synchronization
- [ ] Complete DEV environment validation and documentation
- [ ] GitHub Actions CI/CD workflow improvements
- [ ] TEST, QA, STAGING, and PROD environments
- [ ] Centralized logging with Loki
- [ ] Additional security and operational improvements

*The checklist reflects implementation progress and planned work; it does not mean every environment or feature is production-ready.*

## Project Philosophy

This project is developed through practical, hands-on implementation.

The focus is not only on creating infrastructure but also on understanding:

- Why each resource is required.
- How Terraform manages infrastructure.
- How Linux services operate.
- How containers communicate.
- How Prometheus collects metrics.
- How Grafana visualizes infrastructure health.
- How alerts help identify operational problems.
- How automation improves consistency.
- How security and cost considerations affect cloud design.

## Author

**Raman Krishnan**

Cloud | DevOps | DevSecOps | Terraform | Azure | Linux | Docker | Prometheus | Grafana

GitHub: https://github.com/ramankrishnan

---

This repository is a continuously evolving hands-on engineering portfolio project.
