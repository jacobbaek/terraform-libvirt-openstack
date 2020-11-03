pipeline {
    agent {
        node {
            label 'openstack-slave'
            customWorkspace "workspace/${env.JOB_NAME}/${env.BUILD_NUMBER}"
        }
    }

    stages {
        stage('make a ready to use terraform') {
            steps {
                sh 'curl -L https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip -o terraform.zip && unzip terraform.zip -d /usr/local/bin'
                sh 'terraform version'
                echo 'done'
            }
        }
    }
}
r
