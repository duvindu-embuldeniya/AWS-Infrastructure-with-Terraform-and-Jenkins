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

        stage('Deploy') {
            steps {
                sshagent(['ec2-jenkins-key']) {
                    sh 'ssh ubuntu@13.51.159.164 -o StrictHostKeyChecking=no "bash /var/www/AWS-Infrastructure-with-Terraform-and-Jenkins/scripts/deploy.sh"'
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
