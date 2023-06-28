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
        stage('SSH transfer') {
        steps([$class: 'BapSshPromotionPublisherPlugin']) {
            sshPublisher(
                continueOnError: false, failOnError: true,
                publishers: [
                    sshPublisherDesc(
                        configName: "remote_server",
                        verbose: true,
                        transfers: [
                            sshTransfer(execCommand: "docker pull lyhan12/jenkins_example"),
                            sshTransfer(execCommand: "docker ps -aq --filter 'name=server' | xargs -r docker stop"),
                            sshTransfer(execCommand: "docker ps -aq --filter 'name=server' | xargs -r docker rm"),
                            sshTransfer(execCommand: "docker run --name server lyhan12/jenkins_example")
//                            sshTransfer(sourceFiles: "helm/**",)
                        ]
                    )
                ]
            )
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
