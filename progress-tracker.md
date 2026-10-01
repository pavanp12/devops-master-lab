# 🚀 DevOps Java Lab

## What are we building?

We start with one small Java Spring Boot application and gradually build a complete DevOps workflow around it.

The goal is **not to become a Java expert**.

The goal is to understand how a real application moves through a DevOps environment:

```text
Code
 ↓
Git
 ↓
GitHub
 ↓
Build & Test
 ↓
Docker
 ↓
Monitoring
 ↓
Jenkins
 ↓
Code Quality
 ↓
Docker Registry
 ↓
Kubernetes
 ↓
AWS / EKS
```

### The main learning principle

> **Build it manually → verify it works → automate it → troubleshoot it → understand why it works.**

---

# 1. Java + Spring Boot

### What is it?

Our Java application is the actual application that we will use throughout the lab.

We use:

* Java 21
* Spring Boot
* Maven

### Why do we need it?

DevOps tools need something to build, test, package, deploy and monitor.

Instead of learning every DevOps tool separately, we use **one simple application** throughout the entire project.

### What did we build?

A simple API:

```text
GET /api/hello
```

We also enabled monitoring endpoints:

```text
/actuator/health
/actuator/health/liveness
/actuator/health/readiness
/actuator/prometheus
/actuator/metrics
```

### What did we learn?

The application is the **center of our entire DevOps lab**.

---

# 2. Maven

### What is Maven?

Maven is the build tool for our Java application.

### Why do we need it?

Before deploying an application, we need to make sure:

* the code compiles
* tests run
* the application can be packaged

### What do we run?

```powershell
mvn clean package
```

Maven performs:

```text
Clean
 ↓
Compile
 ↓
Test
 ↓
Package
 ↓
JAR
```

The result is:

```text
target/devops-java-lab-1.0.0.jar
```

### What did we learn?

Maven converts our source code into a **buildable application artifact**.

---

# 3. Git

### What is Git?

Git is our version-control system.

### Why do we need it?

We need to track changes to our:

* Java code
* Docker files
* Jenkinsfile
* Kubernetes files
* Terraform
* CI/CD configuration

### Basic workflow

```text
Change
 ↓
git add
 ↓
git commit
 ↓
git push
```

### What did we learn?

Git gives us a history of what changed and allows us to safely manage our project.

---

# 4. GitHub

### What is GitHub?

GitHub is our remote Git repository.

Our repository:

```text
pavanp12/devops-master-lab
```

### Why do we need it?

Our source code needs to be available remotely so tools such as Jenkins can retrieve it.

The relationship is:

```text
Our PC
 ↓
Git
 ↓
GitHub
 ↓
Jenkins
```

### What did we learn?

Git manages the repository locally.

GitHub stores and shares that repository remotely.

---

# 5. Docker

### What is Docker?

Docker packages our application into a container image.

### Why do we need it?

We want our application to run consistently without depending on the environment where it is deployed.

Instead of saying:

> "It works on my laptop."

we package the application and its runtime environment together.

### Flow

```text
Java Application
 +
JAR
 ↓
Docker Image
 ↓
Docker Container
```

### Important distinction

**Image**

```text
Packaged application
```

**Container**

```text
Running instance of an image
```

### Example

```powershell
docker build -t devops-java-lab:1.0 .
```

---

# 6. Docker Compose

### What is Docker Compose?

Docker Compose allows us to run multiple containers as one environment.

### Why do we need it?

Our application doesn't exist alone.

We also need monitoring tools.

Our local environment contains:

```text
Docker Compose
      │
      ├── Java App
      ├── Prometheus
      └── Grafana
```

We can start everything with:

```powershell
docker compose up -d
```

Check everything with:

```powershell
docker compose ps
```

### Why is this useful?

Instead of starting three containers manually, one command starts the environment.

---

# 7. Prometheus

### What is Prometheus?

Prometheus is our metrics-monitoring system.

### Why do we need it?

Running an application isn't enough.

We also want to know:

* Is it healthy?
* How much memory is it using?
* How many requests are coming in?
* What is happening inside the JVM?

Our Spring Boot application exposes:

```text
/actuator/prometheus
```

Prometheus collects those metrics.

### Flow

```text
Spring Boot
 ↓
Actuator
 ↓
Prometheus
 ↓
Metrics
```

### What did we verify?

The Prometheus target was successfully detected as:

```text
UP
```

---

# 8. Grafana

### What is Grafana?

Grafana displays metrics visually.

### Why do we need it?

Prometheus provides the metrics, but Grafana makes them easier to understand through:

* graphs
* dashboards
* visualizations

### Flow

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

### Example metric

```text
jvm_memory_used_bytes
```

### What did we learn?

Prometheus = **collect and query metrics**

Grafana = **visualize metrics**

---

# 9. Jenkins

### What is Jenkins?

Jenkins is our CI/CD automation server.

### Why do we need it?

Without Jenkins, we would manually perform:

```text
Build
 ↓
Test
 ↓
Code analysis
 ↓
Docker build
```

every time we change the project.

Jenkins automates these steps.

### Our pipeline

```text
GitHub
 ↓
Jenkins
 ↓
Maven
 ↓
Tests
 ↓
SonarQube
 ↓
Quality Gate
```

### What did we learn?

Jenkins turns individual commands into an **automated pipeline**.

---

# 10. Jenkins Tools

Jenkins runs on Windows, so we explicitly configured the tools it needs.

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

### Git

```text
C:\Program Files\Git\cmd\git.exe
```

### Why?

Jenkins needs to know:

> "Where are the tools I should use?"

This is an important Jenkins administration concept.

---

# 11. Jenkinsfile

### What is a Jenkinsfile?

A Jenkinsfile stores our pipeline as code.

Instead of manually telling Jenkins what to do every time, we define the workflow in the repository.

### Our pipeline conceptually does:

```text
Checkout
 ↓
Maven Build + Tests
 ↓
SonarQube Analysis
 ↓
Quality Gate
 ↓
Docker Build
```

### Why is this important?

The pipeline itself becomes part of the project and can be version-controlled with Git.

---

# 12. SonarQube

### What is SonarQube?

SonarQube performs automated code-quality analysis.

### Why do we need it?

A successful compilation doesn't necessarily mean that code is good quality.

We want an automated quality check before allowing the pipeline to continue.

### Flow

```text
Jenkins
 ↓
Maven
 ↓
SonarQube Scanner
 ↓
SonarQube
 ↓
Code Analysis
```

Our project:

```text
DevOps Java Lab
```

Project key:

```text
devops-java-lab
```

---

# 13. SonarQube Token

### Why do we need a token?

Jenkins needs permission to send the analysis to SonarQube.

We therefore created a SonarQube token.

We **do not put the token directly into the Jenkinsfile**.

Instead:

```text
SonarQube Token
      ↓
Jenkins Credential
      ↓
Jenkins Pipeline
```

This is safer than hardcoding credentials in source code.

---

# 14. SonarQube Quality Gate

### What is a Quality Gate?

The Quality Gate is the decision point after SonarQube analyzes the project.

Conceptually:

```text
Code
 ↓
SonarQube Analysis
 ↓
Quality Gate
```

The result can determine whether the pipeline should continue.

```text
Quality Gate
      │
 ┌────┴────┐
 ↓         ↓
PASS      FAIL
 ↓         ↓
Continue  Stop
```

Our project previously achieved:

```text
PASSED ✅
```

### Why is this useful?

It prevents the CI/CD pipeline from blindly continuing when the configured code-quality conditions aren't satisfied.

---

# 15. What happens when we click "Build Now"?

This is the most important part of the lab.

When Jenkins starts the pipeline:

```text
GitHub
   ↓
Get latest source code
   ↓
Maven
   ↓
Compile
   ↓
Run tests
   ↓
SonarQube
   ↓
Analyze code
   ↓
Quality Gate
   ↓
Docker Build
```

So Jenkins is effectively coordinating the tools we learned individually.

---

# 16. Why do we need all these tools?

Each tool solves a different problem.

| Tool             | Problem it solves                  |
| ---------------- | ---------------------------------- |
| Java/Spring Boot | Application                        |
| Maven            | Build & test                       |
| Git              | Version control                    |
| GitHub           | Remote source repository           |
| Docker           | Containerization                   |
| Docker Compose   | Run multiple containers            |
| Prometheus       | Collect metrics                    |
| Grafana          | Visualize metrics                  |
| Jenkins          | Automate CI/CD                     |
| SonarQube        | Code-quality analysis              |
| Quality Gate     | Control whether pipeline continues |

The important lesson is:

> **DevOps isn't about memorizing tools. It's about understanding how the tools work together to move software from code to a reliable running system.**

---

# 17. Where we are now

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
Prometheus
        ↓
Grafana
        ↓
Jenkins
        ↓
SonarQube
        ↓
Quality Gate ✅
```
