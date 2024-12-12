currentBuild.displayName = 'Notification-#' + currentBuild.number

pipeline {
    agent any
    environment {
        registry = '741448919997.dkr.ecr.us-east-1.amazonaws.com/middleware/graviton'
        dockerImage = '' // Replace with your actual AWS credentials ID in Jenkins
        GIT_COMMIT_ID = sh(returnStdout: true, script: 'git rev-parse --short=10 HEAD').trim()
    }
    stages {
        stage('Checkout') {
            steps {
                // Clone the GitHub repository
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'aws-credentials', url: 'https://github.com/Iranna1233/python-arm64-app']])
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image for ARM64
               //     sh 'sudo chmod 660 /var/run/docker.sock'
                    img = registry + ":${env.BUILD_ID}" + '-' + "${GIT_COMMIT_ID}"
                    tags = "Graviton"
                    dockerImage0 = docker.build(registry + ":${tags}", "--platform linux/arm64 .")
               
                }
            }
        }
        stage('Push Docker Image') {
           steps {
                script {
                    // Use the correct protocol in the Docker registry URL
                    docker.withRegistry('https://741448919997.dkr.ecr.us-east-1.amazonaws.com', 'aws-credentials') {
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 741448919997.dkr.ecr.us-east-1.amazonaws.com"
                        dockerImage0.push()
                     
                    }
                }
            }
        }
    }
}

// pipeline {
//     agent any
//     environment {
//         registry = '741448919997.dkr.ecr.us-east-1.amazonaws.com/middleware/graviton'
//         dockerImage = ''
//         registryCredential = 'aws-credentials' // Replace with your actual AWS credentials ID in Jenkins
//         GIT_COMMIT_ID = sh(returnStdout: true, script: 'git rev-parse --short=10 HEAD').trim()
//     }
//     stages {
//         stage('Clone Repository') {
//             steps {
//                 // Clone the GitHub repository
//                 checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'aws-credentials', url: 'https://github.com/Iranna1233/python-arm64-app']])
//             }
//         }
//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     // Build the Docker image for ARM64
                    
//                     img = registry + ":${env.BUILD_ID}" + '-' + "${GIT_COMMIT_ID}"
//                     tags = "latest"
//                     dockerImage0 = docker.build(registry + ":${tags}")
//                     dockerImage1 = docker.build("${img}")
//                 }
//             }
//         }
//         stage('Push Docker Image') {
//             steps {
//                 script {
//                     docker.withRegistry( ) {
//                         dockerImage0.push()
//                         dockerImage1.push()
//                     }
//                 }
//             }
//         }
//     }
    
