pipeline {
    agent any
    environment {
        registry = '474668409862.dkr.ecr.us-east-1.amazonaws.com/middleware-dev-repo'
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
                    sh "sudo -S chmod 777 /var/run/docker.sock"
                    img = registry + ":${env.BUILD_ID}" + '-' + "${GIT_COMMIT_ID}"
                    tags = "latest"
                    dockerImage0 = docker.build(registry + ":${tags}")
                    dockerImage1 = docker.build("${img}")
                }
            }
        }
        // stage('Push Docker Image') {
        //     steps {
        //         script {
        //             docker.withRegistry('https://474668409862.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:aws ') {
        //                 dockerImage0.push()
        //                 dockerImage1.push()
        //             }
        //         }
        //     }
        // }
    }
    // post {
    //     always {
    //         // Clean up any dangling images
    //         sh "docker image prune -f"
    //     }
    // }
}



// pipeline {
//     agent any
//     environment {
//         registry = '474668409862.dkr.ecr.us-east-1.amazonaws.com/middleware-dev-repo'
//         dockerImage = ''
//         registryCredential = 'aws-credentials' // Replace with your actual AWS credentials ID in Jenkins
//     }
//     stages {
//         stage('Clone Repository') {
//             steps {
//                 // Clone the GitHub repository
//                 git 'https://github.com/Iranna1233/python-arm64-app.git'
//             }
//         }

// // stage('Build Docker Image') {
// //     steps {
// //         script {
// //             // Install buildx and configure it for the pipeline environment (if not already installed)
// //             sh '''
// //             mkdir -p ~/.docker/cli-plugins
// //             curl -sSL https://github.com/docker/buildx/releases/latest/download/docker-buildx-linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
// //             chmod +x ~/.docker/cli-plugins/docker-buildx
// //             '''

// //             // // Create and bootstrap a new builder instance for buildx
// //             // sh '''
// //             // docker build create --name mybuilder --use
// //             // docker buildx inspect --bootstrap
// //             // '''

// //             // Build the Docker image using buildx for ARM64 platform
// //             sh "docker build --platform linux/arm64 -t 474668409862.dkr.ecr.us-east-1.amazonaws.com/middleware-dev-repo:10 ."

// //             // Optional: Push the image to the registry (ECR in your case)
// //             sh '''
// //             aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 474668409862.dkr.ecr.us-east-1.amazonaws.com
// //             docker build --platform linux/arm64 --push -t 474668409862.dkr.ecr.us-east-1.amazonaws.com/middleware-dev-repo:10 .
// //             '''
// //         }
// //     }
// // }

        
//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     // Build the Docker image for ARM64
//                    // dockerImage = docker.build("${registry}:${env.BUILD_ID}", "--platform linux/arm64 .")
//                     sh '''docker buildx build --platform linux/arm64 -t 474668409862.dkr.ecr.us-east-1.amazonaws.com/middleware-dev-repo:${env.BUILD_ID} .'''
//                 }
//             }
//          }
//          stage('Push Docker Image') {
//              steps {
//                  script {
//                      docker.withRegistry('https://474668409862.dkr.ecr.us-east-1.amazonaws.com', registryCredential) {
//                          dockerImage.push()
//                         dockerImage.push('latest')
//                     }
//                  }
//             }
//          }
//     }
//     // post {
//     //     always {
//     //         // Clean up any dangling images
//     //         sh "docker image prune -f"
//     //     }
//     // }
// }
