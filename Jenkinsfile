pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                sh 'ls -lart'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('/var/www/AWS-Infrastructure-with-Terraform-and-Jenkins') {
                    sh '''
                        echo "================ Terraform Init ================"
                        terraform init
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('/var/www/AWS-Infrastructure-with-Terraform-and-Jenkins') {
                    sh '''
                        echo "================ Terraform Plan ================"
                        terraform plan -var-file=terraform.tfvars -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('/var/www/AWS-Infrastructure-with-Terraform-and-Jenkins') {
                    sh '''
                        echo "================ Terraform Apply ================"
                        terraform apply -auto-approve tfplan
                    '''
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-jenkins-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@56.228.10.226 \
                        "bash /var/www/AWS-Infrastructure-with-Terraform-and-Jenkins/scripts/deploy.sh"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}