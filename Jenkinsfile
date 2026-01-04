pipeline {
    agent any

    stage('Deploy') {
        steps {
            sshagent(['ec2-jenkins-key']) {
                sh 'ssh ubuntu@56.228.10.226 -o StrictHostKeyChecking=no "bash /var/www/AWS-Infrastructure-with-Terraform-and-Jenkins/scripts/deploy.sh"'
            }
        }
    }
}
