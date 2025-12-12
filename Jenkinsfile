pipeline {
    agent any

    environment {
        // You can define environment variables here if needed
        DOCKER_IMAGE = 'agrilite_image'
        DOCKER_CONTAINER = 'agrilite_container'
    }

    stages {

        stage('Checkout SCM') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main',
                    url: 'https://github.com/naveenvelu10/AgriBuzzLite_Test.git',
                    credentialsId: 'github-token' // Make sure you added your GitHub token in Jenkins
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${DOCKER_IMAGE} -f ${WORKSPACE}/SourceCode/Dockerfile ${WORKSPACE}/SourceCode"
            }
        }

        stage('Stop Existing Container') {
            steps {
                echo 'Stopping existing container if running...'
                sh """
                docker stop ${DOCKER_CONTAINER} || true
                docker rm ${DOCKER_CONTAINER} || true
                """
            }
        }

        stage('Run Container') {
            steps {
                echo 'Running Docker container...'
                sh """
                docker run -d --name ${DOCKER_CONTAINER} -p 8080:80 ${DOCKER_IMAGE}
                """
            }
        }

    }

    post {
        success {
            echo 'Deployment succeeded!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}

