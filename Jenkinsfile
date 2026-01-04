pipeline {
    agent any

    parameters {
        booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Run Terraform plan')
        booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Run Terraform apply')
        booleanParam(name: 'DEPLOY_APP', defaultValue: true, description: 'Deploy application to EC2')
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
                sh '''
                    echo "================ Terraform Init ================"
                    terraform init
                '''
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.PLAN_TERRAFORM }
            }
            steps {
                sh '''
                    echo "================ Terraform Plan ================"
                    terraform plan -var-file=tfvars.sample
                '''
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.APPLY_TERRAFORM }
            }
            steps {
                sh '''
                    echo "================ Terraform Apply ================"
                    terraform apply -var-file=tfvars.sample -auto-approve
                '''
            }
        }

        stage('Deploy to EC2') {
            when {
                expression { params.DEPLOY_APP }
            }
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
            echo "❌ Pipeline failed!"
        }
    }
}
