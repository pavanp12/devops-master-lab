pipeline {
    agent any

    tools {
        jdk 'JDK-21'
        maven 'Maven-3.9.16'
    }

    environment {
        IMAGE = "devops-java-lab:${BUILD_NUMBER}"
        DOCKER_IMAGE = "pavandevp12/devops-java-lab:${BUILD_NUMBER}"
    }


    stages {

        stage('Test') {
            steps {
                bat 'mvn -B clean verify'
            }
        }


       stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    bat 'mvn -B org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=devops-java-lab'
                }
            }
        }

        stage('Quality Gate') {
    steps {
        timeout(time: 5, unit: 'MINUTES') {
            waitForQualityGate abortPipeline: true
        }
    }
}
        

        stage('Docker Build') {
            steps {
                bat 'docker build -t %IMAGE% .'
            }
        }

        stage('Docker push'){
            steps {
               withCredentials([usernamePassword( credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_TOKEN' )]) { bat ''' docker tag %IMAGE% %DOCKER_IMAGE% docker login -u %DOCKERHUB_USERNAME% -p %DOCKERHUB_TOKEN% docker push %DOCKER_IMAGE% ''' } }
        }

        stage('Deploy') {
            steps {
                echo 'Deploy stage will be configured later with Kubernetes/Helm.'
            }
        }
    }
}