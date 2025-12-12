pipeline {
    agent any

    environment {
        APP_NAME = "agrilite_front"                   // Name for your Docker container
        IMAGE_NAME = "agrilite_image"                 // Name for Docker image
        APP_DIR = "/var/www/html"                     // App location inside container
        HOST_DIR = "${WORKSPACE}/SourceCode"          // Local project folder on Jenkins server
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main',
                    url: 'https://github.com/naveenvelu10/AgriBuzzLite_Test.git',
                    credentialsId: 'github-token'   // Use the Jenkins credential you created for GitHub token
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${IMAGE_NAME} -f ${HOST_DIR}/Dockerfile ${HOST_DIR}"
            }
        }

        stage('Stop Existing Container') {
            steps {
                echo 'Stopping old container if exists...'
                sh """
                if [ \$(docker ps -q -f name=${APP_NAME}) ]; then
                    docker stop ${APP_NAME}
                    docker rm ${APP_NAME}
                fi
                """
            }
        }

        stage('Run Container') {
            steps {
                echo 'Starting new container...'
                sh """
                docker run -d --name ${APP_NAME} -p 8056:80 ${IMAGE_NAME}
                """
            }
        }

        stage('Cleanup') {
            steps {
                echo 'Removing dangling images...'
                sh "docker image prune -f"
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}

