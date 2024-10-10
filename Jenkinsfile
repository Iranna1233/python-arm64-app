pipeline {
    agent { label 'CIagent' }
    environment {
        registry = '474668409862.dkr.ecr.us-east-1.amazonaws.com/middleware-dev-repo'
        dockerImage = ''
        registryCredential = 'aws-credentials' // Replace with your actual AWS credentials ID in Jenkins
    }
    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git 'https://github.com/Iranna1233/python-arm64-app.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image for ARM64
                    dockerImage = docker.build("${registry}:${env.BUILD_ID}", "--platform linux/arm64 .")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://474668409862.dkr.ecr.us-east-1.amazonaws.com', registryCredential) {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
    // post {
    //     always {
    //         // Clean up any dangling images
    //         sh "docker image prune -f"
    //     }
    // }
}
