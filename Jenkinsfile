pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        REPO_URL = 'https://github.com/duvindu-embuldeniya/AWS-Infrastructure-with-Terraform-and-Jenkins.git'
        BRANCH   = 'main'
    }

    stages {

        stage('Checkout (Clone or Pull)') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh '''
                        if [ ! -d ".git" ]; then
                            echo "📥 First run: cloning repository"
                            git clone -b ${BRANCH} ${REPO_URL} .
                        else
                            echo "🔄 Repo exists: pulling latest changes"
                            git pull origin ${BRANCH}
                        fi

                        echo "📂 Workspace contents:"
                        ls -lart
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh '''
                        echo "================ Terraform Init ================"
                        terraform init
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh '''
                        echo "================ Terraform Plan ================"
                        terraform plan -var-file=terraform.tfvars -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh '''
                        echo "================ Terraform Apply ================"
                        terraform apply -auto-approve tfplan
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['ec2-jenkins-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@13.51.159.164 \
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
