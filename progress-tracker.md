# 🚀 DevOps Java Lab

> A beginner-friendly, enterprise-style DevOps learning project built step by step on Windows.

**Goal:** Start with a simple Java application and gradually build a complete DevOps pipeline around it.

---

## 📌 Project Status

| Area | Status |
|---|---|
| Java 21 | ✅ Done |
| Spring Boot | ✅ Done |
| Maven | ✅ Done |
| Git | ✅ Done |
| GitHub | ✅ Done |
| Docker | ✅ Done |
| Docker Compose | ✅ Done |
| Prometheus | ✅ Done |
| Grafana | ✅ Done |
| Jenkins | ✅ Done |
| SonarQube | ✅ Done |
| SonarQube Quality Gate | ✅ Passed |
| Docker Registry | ⏳ Next |
| Kubernetes | ⏳ Planned |
| Helm | ⏳ Planned |
| Terraform | ⏳ Planned |
| AWS / EKS | ⏳ Planned |
| Ansible | ⏳ Planned |
| GitHub Actions | ⏳ Planned |

---

# 🧭 What Are We Building?

Instead of learning DevOps tools separately, this project uses **one small Java application** as the center of the entire lab.

```text
Developer
    ↓
 GitHub
    ↓
 Jenkins
    ↓
 Maven Build + Tests
    ↓
 SonarQube
    ↓
 Quality Gate ✅
    ↓
 Docker Build
    ↓
 Docker Registry
    ↓
 Kubernetes
    ↓
 Prometheus + Grafana
```

The final goal is to understand how these tools work together in a real DevOps workflow.

---

# ☕ 1. Java + Spring Boot

We started with a very small Spring Boot Java application.

The application is intentionally simple because the purpose of this project is **DevOps**, not complicated Java development.

### Technology

- Java 21 LTS
- Spring Boot
- Maven

### Main API

```text
GET /api/hello
```

Example response:

```json
{
  "timestamp": "2026-09-29T13:48:20.002255300Z",
  "message": "Hello from the DevOps Java Lab",
  "version": "1.0.0"
}
```

Important monitoring endpoints:

```text
/actuator/health
/actuator/health/liveness
/actuator/health/readiness
/actuator/prometheus
/actuator/metrics
```

### Why?

We need an actual application to:

- build
- test
- containerize
- scan
- deploy
- monitor

---

# 🧰 2. Maven

Maven is the **build tool** for the Java application.

We use Maven to:

- download dependencies
- compile Java code
- run tests
- create the JAR
- verify the build

Build:

```powershell
mvn clean package
```

This creates:

```text
target/devops-java-lab-1.0.0.jar
```

Run locally:

```powershell
mvn spring-boot:run
```

Application:

```text
http://localhost:8080
```

**Important:** The Java application does not need to be running all the time. We run it manually when we want to test it locally. Jenkins can build and test it without keeping the server running.

---

# 🌱 3. Git

Git provides **version control**.

We initialized Git inside the actual project directory and created a `.gitignore` so files such as Maven's `target/` directory and IDE files are not committed.

Git lets us track changes to:

- Java code
- Jenkinsfile
- Docker configuration
- Kubernetes manifests
- Terraform
- documentation
- CI/CD configuration

Basic workflow:

```text
Change
  ↓
git add
  ↓
git commit
  ↓
git push
```

---

# 🐙 4. GitHub

The local repository was connected to GitHub.

Repository:

```text
https://github.com/pavanp12/devops-master-lab
```

Main branch:

```text
main
```

GitHub is the central source-code repository and Jenkins checks out the project from it.

---

# 🐳 5. Docker

Docker packages the application into a portable container image.

```text
Java Application
      +
JAR File
      ↓
Docker Image
      ↓
Docker Container
```

We successfully built:

```powershell
docker build -t devops-java-lab:1.0 .
```

And ran:

```powershell
docker run --name devops-java-lab-container -p 8080:8080 devops-java-lab:1.0
```

Then verified:

```text
http://localhost:8080/api/hello
```

### Important lesson

**Image** = packaged application.

**Container** = running instance of the image.

---

# 🧩 6. Docker Compose

Docker Compose lets us run multiple services together.

Our local environment contains:

```text
Docker Compose
     │
     ├── Java App       :8080
     ├── Prometheus     :9091
     └── Grafana        :3000
```

We successfully started it with:

```powershell
docker compose up -d
```

And checked it with:

```powershell
docker compose ps
```

### Current local ports

| Service | URL |
|---|---|
| Java App | `http://localhost:8080` |
| Jenkins | `http://localhost:9090` |
| Prometheus | `http://localhost:9091` |
| Grafana | `http://localhost:3000` |
| SonarQube | `http://localhost:9000` |

Prometheus uses container port `9090`, but host port `9091` because Jenkins already uses host port `9090`.

---

# 📊 7. Prometheus

Prometheus is used for **metrics monitoring**.

The Spring Boot application exposes metrics through:

```text
/actuator/prometheus
```

We verified that the endpoint returns Prometheus metrics.

Prometheus successfully scraped the application, and the target was verified as:

```text
UP
```

Prometheus:

```text
http://localhost:9091
```

### Simple explanation

Prometheus repeatedly asks the application:

> "How are you doing?"

The application responds with metrics such as JVM and HTTP metrics.

---

# 📈 8. Grafana

Grafana turns metrics into visual dashboards and graphs.

Grafana:

```text
http://localhost:3000
```

We connected Grafana to Prometheus using:

```text
http://prometheus:9090
```

The connection passed its test.

We also created a visualization using:

```text
jvm_memory_used_bytes
```

Monitoring flow:

```text
Spring Boot
    ↓
Actuator
    ↓
Prometheus
    ↓
Grafana
    ↓
Dashboard
```

---

# ⚙️ 9. Jenkins

Jenkins is our **CI/CD automation server**.

Jenkins is running on Windows at:

```text
http://localhost:9090
```

Version:

```text
Jenkins 2.568.3
```

Job:

```text
java-lab-jenkins
```

---

# 🛠️ 10. Jenkins Tool Configuration

Because Jenkins is running on Windows, we explicitly configured the tools.

### Git

```text
C:\Program Files\Git\cmd\git.exe
```

### Java

```text
JDK-21
C:\Program Files\Java\jdk-21
```

### Maven

```text
Maven-3.9.16
C:\tools\apache-maven-3.9.16
```

This taught an important Jenkins concept:

> Jenkins needs to know where the required tools are installed.

---

# 📜 11. Jenkinsfile

The pipeline is stored as code in:

```text
Jenkinsfile
```

The current pipeline performs:

```text
Test
  ↓
SonarQube Analysis
  ↓
Docker Build
  ↓
Deploy placeholder
```

Because Jenkins runs on Windows, pipeline commands use:

```groovy
bat
```

rather than Linux:

```groovy
sh
```

---

# 🧪 12. Jenkins + Maven

Jenkins runs:

```text
mvn -B clean verify
```

This:

- cleans the previous build
- compiles the application
- runs tests
- verifies the build

The Maven build completed successfully.

---

# 🔎 13. SonarQube

SonarQube provides **code quality analysis**.

We installed SonarQube using Docker.

SonarQube:

```text
http://localhost:9000
```

Project:

```text
DevOps Java Lab
```

Project key:

```text
devops-java-lab
```

We created a SonarQube token and stored it securely in Jenkins as a credential.

Jenkins was configured with:

```text
Server name: sonarqube
Credential: sonarqube-token
```

The SonarQube Scanner plugin was installed in Jenkins.

---

# 🛡️ 14. SonarQube Quality Gate

Jenkins sends the project to SonarQube for analysis.

```text
Jenkins
   ↓
Maven
   ↓
SonarQube Analysis
   ↓
Quality Gate
```

The project successfully passed the Quality Gate:

```text
✅ PASSED
```

---

# 🔄 15. Current CI Pipeline

We now have a working CI pipeline:

```text
Developer
    │
    ▼
 GitHub
    │
    ▼
 Jenkins
    │
    ├──► Maven Build + Tests
    │
    ├──► SonarQube Analysis
    │
    ├──► Quality Gate ✅
    │
    └──► Docker Build
```

This is a major milestone: Jenkins is now automating the build workflow instead of us manually running every step.

---

# 🧠 What We Have Learned

### Source control

```text
Git → GitHub
```

### Build automation

```text
Maven → Build + Test
```

### Containerization

```text
JAR → Docker Image → Container
```

### Multi-container environments

```text
Docker Compose → App + Prometheus + Grafana
```

### Monitoring

```text
Prometheus → Metrics
```

### Visualization

```text
Grafana → Dashboards
```

### Continuous Integration

```text
Jenkins → Automated pipeline
```

### Code quality

```text
SonarQube → Code analysis
```

### Quality control

```text
Quality Gate → Pass/Fail based on configured conditions
```

---

# 🧯 Real Problems We Solved

This project was also useful because we encountered real DevOps troubleshooting situations.

### Maven: wrong directory

Running Maven from the outer project folder caused:

```text
No plugin found for prefix 'spring-boot'
```

The actual problem was that the command was being run outside the directory containing:

```text
pom.xml
```

---

### Jenkins: `sh` on Windows

The original Jenkinsfile used:

```groovy
sh
```

Windows Jenkins requires:

```groovy
bat
```

---

### Jenkins: Java not found

Jenkins initially could not find Java.

We configured:

```text
JDK-21
C:\Program Files\Java\jdk-21
```

---

### Jenkins: Maven configuration

We configured:

```text
Maven-3.9.16
C:\tools\apache-maven-3.9.16
```

---

### Docker: daemon not running

Docker commands initially failed because the Docker engine was not running.

Starting Docker Desktop fixed it.

---

### Docker: `.dockerignore`

The Docker build initially could not find:

```text
target/devops-java-lab-1.0.0.jar
```

because `target/` was excluded by `.dockerignore`.

We corrected it so the JAR could be included in the Docker build context.

---

### Port conflict

Jenkins uses:

```text
9090
```

Prometheus also normally uses:

```text
9090
```

So we mapped:

```text
localhost:9091 → Prometheus container:9090
```

---

### SonarQube Maven plugin

Maven could not resolve the short `sonar` prefix in Jenkins.

We changed the pipeline to explicitly invoke:

```text
org.sonarsource.scanner.maven:sonar-maven-plugin:sonar
```

The SonarQube analysis then completed successfully.

---

# 📂 Important Project Files

```text
devops-java-lab/
│
├── src/
├── pom.xml
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── .gitignore
├── .dockerignore
├── sonar-project.properties
│
├── prometheus/
│   └── prometheus.yml
│
├── grafana/
│   ├── dashboards/
│   └── provisioning/
│
├── k8s/
├── helm/
├── terraform/
├── ansible/
└── README.md
```

The later-stage Kubernetes, Helm, Terraform and Ansible directories are prepared for future parts of the lab and have not yet been used as the main deployment path.

---

# 🗺️ DevOps Roadmap

## ✅ Phase 1 — Application

```text
Java
Spring Boot
Maven
```

## ✅ Phase 2 — Source Control

```text
Git
GitHub
```

## ✅ Phase 3 — Containers

```text
Docker
Docker Compose
```

## ✅ Phase 4 — Local Observability

```text
Prometheus
Grafana
```

## ✅ Phase 5 — Code Quality

```text
SonarQube
Quality Gate
```

## ✅ Phase 6 — CI

```text
Jenkins
Maven
SonarQube
Docker
```

## ⏳ Phase 7 — Container Registry

Next:

```text
Docker Hub
```

Jenkins will eventually build and push the Docker image.

## ⏳ Phase 8 — Kubernetes

Then we will learn:

```text
Cluster
Nodes
Pods
Deployments
Services
ConfigMaps
Secrets
Ingress
```

## ⏳ Phase 9 — Helm

Package the Kubernetes application with Helm.

## ⏳ Phase 10 — Infrastructure as Code

Learn Terraform and use it to provision infrastructure.

## ⏳ Phase 11 — AWS / EKS

Move from local Kubernetes toward:

```text
AWS
 ↓
EKS
 ↓
Kubernetes
```

## ⏳ Phase 12 — Ansible

Learn configuration management and server automation.

## ⏳ Phase 13 — GitHub Actions

Add GitHub Actions as another CI/CD system and compare its workflow with Jenkins.

---

# 🎯 Long-Term Architecture

```text
                         GitHub
                            │
                            ▼
                     CI/CD Pipeline
                            │
                       ┌────┴────┐
                       ▼         ▼
                    Jenkins   GitHub Actions
                       │
                       ▼
                     Maven
                       │
                       ▼
                   SonarQube
                       │
                  Quality Gate
                       │
                       ▼
                     Docker
                       │
                       ▼
                Docker Registry
                       │
                       ▼
                   Kubernetes
                       │
              ┌────────┴────────┐
              ▼                 ▼
         Prometheus          Grafana
              │                 │
              └────────┬────────┘
                       ▼
                 Observability

Infrastructure:
Terraform → AWS → EKS

Packaging:
Helm

Configuration:
Ansible
```

---

# 🧑‍💻 Useful Commands

Use the **VS Code integrated PowerShell terminal**.

Make sure you are inside the directory containing `pom.xml`.

```powershell
cd C:\Users\panch\Desktop\devops-java-lab\devops-java-lab
```

### Git

```powershell
git status
```

### Build Java application

```powershell
mvn clean package
```

### Run application locally

```powershell
mvn spring-boot:run
```

### Build Docker image

```powershell
docker build -t devops-java-lab:1.0 .
```

### Start Compose

```powershell
docker compose up -d
```

### Check containers

```powershell
docker compose ps
```

### Stop Compose

```powershell
docker compose down
```

---

# 🎯 The Main Idea

The Java application is deliberately simple.

The goal is to learn how the DevOps ecosystem fits together:

```text
Code
 ↓
Git
 ↓
GitHub
 ↓
Jenkins
 ↓
Build + Test
 ↓
SonarQube
 ↓
Quality Gate
 ↓
Docker
 ↓
Registry
 ↓
Kubernetes
 ↓
Helm
 ↓
AWS / EKS
 ↓
Prometheus + Grafana
```

> **Learning principle:** Build it manually → verify it works → automate it → troubleshoot it → understand why it works.

---

## 🚀 Current Position

### Completed

```text
Java + Spring Boot
        ↓
      Maven
        ↓
       Git
        ↓
      GitHub
        ↓
      Docker
        ↓
 Docker Compose
        ↓
Prometheus + Grafana
        ↓
     Jenkins
        ↓
    SonarQube
        ↓
 Quality Gate ✅
```

### Next

```text
Docker Registry
      ↓
Kubernetes
      ↓
Helm
      ↓
Terraform
      ↓
AWS / EKS
      ↓
Ansible
      ↓
GitHub Actions
      ↓
Enterprise-style CI/CD
```
