pipeline {
    agent any
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
            // Install buildx and configure it for the pipeline environment (if not already installed)
            sh '''
            mkdir -p ~/.docker/cli-plugins
            curl -sSL https://github.com/docker/buildx/releases/latest/download/docker-buildx-linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
            chmod +x ~/.docker/cli-plugins/docker-buildx
            '''

            // Build the Docker image using buildx for ARM64 platform
            sh "docker buildx build --platform linux/arm64 -t 474668409862.dkr.ecr.us-east-1.amazonaws.com/middleware-dev-repo:${env.BUILD_ID} ."

            // Optional: Push the image to the registry (ECR in your case)
            sh """
            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 474668409862.dkr.ecr.us-east-1.amazonaws.com
            docker buildx build --platform linux/arm64 --push -t 474668409862.dkr.ecr.us-east-1.amazonaws.com/middleware-dev-repo:${env.BUILD_ID} .
            """
        }
    }
}






        
        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             // Build the Docker image for ARM64
        //            // dockerImage = docker.build("${registry}:${env.BUILD_ID}", "--platform linux/arm64 .")
        //             sh 'docker buildx build --platform linux/arm64 -t 474668409862.dkr.ecr.us-east-1.amazonaws.com/middleware-dev-repo:${env.BUILD_ID} .'
        //         }
        //     }
        // }
        // stage('Push Docker Image') {
        //     steps {
        //         script {
        //             docker.withRegistry('https://474668409862.dkr.ecr.us-east-1.amazonaws.com', registryCredential) {
        //                 dockerImage.push()
        //                 dockerImage.push('latest')
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
