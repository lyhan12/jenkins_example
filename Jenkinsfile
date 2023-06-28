pipeline {
    agent any
    environment {
        DOCKERHUB = credentials("dockerhub")
        
    }
    stages {
        stage('Check Out') {
            steps {
                echo 'check out'
                git branch: 'main',
                    credentialsId: 'github', // For Private Repository
                    url: 'https://github.com/lyhan12/jenkins_example'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t jenkins_example .'
            }
        }
        stage('Docker Upload') {
            steps {
                echo "upload"
                
                sh 'docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW'
                sh 'docker tag jenkins_example lyhan12/jenkins_example'
                sh 'docker push lyhan12/jenkins_example'
                sh 'docker logout'
            }
        }
    }
    post {
        success {
            slackSend(
                channel: '#일반',
                message: "${env.BUILD_NUMBER} ${env.JOB_NAME}")
        }
    }
}
