pipeline {
    agent {
        kubernetes {
            label 'maven'
        }
    }
    environment {
        DOCKER_CREDENTIAL_ID = 'aliyun'
        GIT_REPO_URL = 'https://github.com/Aerith789/'
        GIT_CREDENTIAL_ID = 'github-key'
        GIT_ACCOUNT = 'Aerith789'
        KUBECONFIG_CREDENTIAL_ID = 'cec20125-d68d-4079-bd48-ac3af0898272'
        REGISTRY = 'registry.cn-hangzhou.aliyuncs.com'
        APP_NAME = 'k8s-cicd-demo'
        SONAR_SERVER_URL = 'http://10.1.3.246:30004'
        SONAR_CREDENTIAL_ID = 'sonarqube-token'
    }
    stages {
        stage('deploy to dev') {
             when {
                  branch 'master'
             }
             steps {
                  input(id: 'deploy-to-dev', message: 'deploy to dev?')
                  sh 'kubectl apply -f deploy/cicd-demo-dev.yaml'
              }
         }
    }
}