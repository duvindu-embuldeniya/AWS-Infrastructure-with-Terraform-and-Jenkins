pipeline {
    agent any

    parameters {
        booleanParam(
            name: 'PLAN_TERRAFORM',
            defaultValue: false,
            description: 'Run Terraform plan'
        )
        booleanParam(
            name: 'APPLY_TERRAFORM',
            defaultValue: false,
            description: 'Run Terraform apply'
        )
    }

    stages {

        stage('Checkout Source Code') {
            steps {
                deleteDir()
                git branch: 'main',
                    url: 'https://github.com/duvindu-embuldeniya/AWS-Infrastructure-with-Terraform-and-Jenkins.git'
                sh 'ls -lart'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.WORKSPACE}/AWS-Infrastructure-with-Terraform-and-Jenkins") {
                    sh '''
                        echo "================= Terraform Init ================="
                        terraform init
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.PLAN_TERRAFORM }
            }
            steps {
                dir("${env.WORKSPACE}/AWS-Infrastructure-with-Terraform-and-Jenkins") {
                    sh '''
                        echo "================= Terraform Plan ================="
                        terraform plan -var-file=terraform.tfvars
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.APPLY_TERRAFORM }
            }
            steps {
                dir("${env.WORKSPACE}/AWS-Infrastructure-with-Terraform-and-Jenkins") {
                    sh '''
                        echo "================= Terraform Apply ================="
                        terraform apply -var-file=terraform.tfvars -auto-approve
                    '''
                }
            }
        }

        stage('Deployment on Production Environment') {
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
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed! Check Terraform or deployment logs."
        }
    }
}
