pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        TF_WORKSPACE = "${WORKSPACE}/terraform"
    }

    triggers {
        // Trigger on every GitHub push
        githubPush()
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/duvindu-embuldeniya/AWS-Infrastructure-with-Terraform-and-Jenkins.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_WORKSPACE}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${TF_WORKSPACE}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_WORKSPACE}") {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_WORKSPACE}") {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

    }

    post {
        always {
            echo 'Cleaning workspace...'
            cleanWs()
        }
        success {
            echo 'Terraform stages completed successfully!'
        }
        failure {
            echo 'Terraform stages failed. Check logs!'
        }
    }
}
