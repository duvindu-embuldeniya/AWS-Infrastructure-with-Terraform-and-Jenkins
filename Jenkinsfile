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

        stage('Test') {
            steps {
                sh '''
                    echo "✅ Test stage running"
                '''
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
