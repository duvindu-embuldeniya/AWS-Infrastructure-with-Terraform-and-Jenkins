pipeline {
    agent any

    stages {

        stage('Deployment on Production Environment') {
            steps {
                sshagent(['ec2-jenkins-key']) {
                    sh '''
                        ssh ubuntu@16.171.242.146 -o StrictHostKeyChecking=no \
                        "bash /var/www/AWS-Infrastructure-with-Terraform-and-Jenkins/scripts/deploy.sh"
                    '''
                }
            }
        }


    }
}
