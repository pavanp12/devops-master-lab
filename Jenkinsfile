pipeline {
    agent any

    tools {
        maven 'Maven-3.9.16'
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