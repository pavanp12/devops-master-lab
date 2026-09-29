pipeline {
    agent any

    tools {
        jdk 'JDK-21'
        maven 'Maven-3.9.16'
        sonarQube 'SonarQube-Scanner'
    }

    environment {
        IMAGE = "devops-java-lab:${BUILD_NUMBER}"
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
                    bat 'mvn -B sonar:sonar -Dsonar.projectKey=devops-java-lab'
                }
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t %IMAGE% .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploy stage will be configured later with Kubernetes/Helm.'
            }
        }
    }
}