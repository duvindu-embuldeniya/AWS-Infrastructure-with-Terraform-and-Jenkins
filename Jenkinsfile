pipeline {
    agent any

    parameters {
        booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
        booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
        booleanParam(name: 'DEPLOY_APP', defaultValue: false, description: 'Check to deploy application via SSH')
    }

    stages {

        stage('Checkout') {
            steps {
                deleteDir()
                git branch: 'main',
                    url: 'https://github.com/duvindu-embuldeniya/AWS-Infrastructure-with-Terraform-and-Jenkins.git'
                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.WORKSPACE}/AWS-Infrastructure-with-Terraform-and-Jenkins") {
                    sh 'echo "=================Terraform Init=================="'
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                        dir("${env.WORKSPACE}/AWS-Infrastructure-with-Terraform-and-Jenkins") {
                            sh 'echo "=================Terraform Plan=================="'
                            sh 'terraform plan -var-file=terraform.tfvars'
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                        dir("${env.WORKSPACE}/AWS-Infrastructure-with-Terraform-and-Jenkins") {
                            sh 'echo "=================Terraform Apply=================="'
                            sh 'terraform apply -var-file=terraform.tfvars -auto-approve'
                        }
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-jenkins-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@16.171.242.146 \
                    "bash /var/www/AWS-Infrastructure-with-Terraform-and-Jenkins/scripts/deploy.sh"
                    '''
                }
            }
        }

    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed! Check Terraform plan/apply or SSH deployment."
        }
    }
}

