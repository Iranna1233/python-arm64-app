pipeline {
    agent any
    environment {
        registry = '741448919997.dkr.ecr.us-east-1.amazonaws.com/middleware/graviton'
        dockerImage = ''
        registryCredential = 'aws-credentials' // Replace with your actual AWS credentials ID in Jenkins
        GIT_COMMIT_ID = sh(returnStdout: true, script: 'git rev-parse --short=10 HEAD').trim()
    }
    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'aws-credentials', url: 'https://github.com/Iranna1233/python-arm64-app']])
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image for ARM64
                    
                    img = registry + ":${env.BUILD_ID}" + '-' + "${GIT_COMMIT_ID}"
                    tags = "latest"
                    dockerImage0 = docker.build(registry + ":${tags}")
                    dockerImage1 = docker.build("${img}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('741448919997.dkr.ecr.us-east-1.amazonaws.com', registryCredential) {
                        dockerImage0.push()
                        dockerImage1.push()
                    }
                }
            }
        }
    }
    
