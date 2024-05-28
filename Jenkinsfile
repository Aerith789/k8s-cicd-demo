pipeline {
    agent {
        kubernetes {
            label 'maven'
        }
    }
    environment {
        DOCKER_CREDENTIAL_ID = 'harbor-key'
        GIT_REPO_URL = '10.1.3.245:28080'
        GIT_CREDENTIAL_ID = 'gitlab'
        GIT_ACCOUNT = 'root'
        KUBECONFIG_CREDENTIAL_ID = 'cec20125-d68d-4079-bd48-ac3af0898272'
        REGISTRY = 'http://10.1.3.245:8081'
        APP_NAME = 'k8s-cicd-demo'
        SONAR_SERVER_URL = 'http://10.1.3.246:30004'
        SONAR_CREDENTIAL_ID = 'sonarqube-token'
    }
    stages {
        stage('unit test') {
            steps {
                sh 'ls'
            }
        }
        stage('sonarqube analysis') {
            steps {
                withCredentials([string(credentialsId: "$SONAR_CREDENTIAL_ID", variable: 'SONAR_TOKEN')]) {
                    withSonarQubeEnv('sonarqube') {
                        sh 'ls'
                    }
                }
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('build $ push') {
            steps {
                sh 'docker build -f Dockerfile -t $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:SNAPSHOT-$BUILD_NUMBER .'
                withCredentials([usernamePassword(passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME', credentialsId: "$DOCKER_CREDENTIAL_ID",)]) {
                    sh 'echo "$DOCKER_PASSWORD" | docker login $REGISTRY -u "$DOCKER_USERNAME" --password-stdin'
                    sh 'docker push $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:SNAPSHOT-$BUILD_NUMBER'
                }
            }
        }

        stage('push latest') {
            when {
                branch 'master'
            }
            steps {
                sh 'docker tag $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:SNAPSHOT-$BUILD_NUMBER #REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:latest'
                sh 'docker push $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:latest'
            }
        }
        stage('deploy to dev') {
            when {
                branch 'master'
            }
            steps {
                input(id: 'deploy-to-dev', message: 'deploy to dev?')
                sh '''
                    sed -i'' "s#REGISTRY#REGISTRY#" deploy/cicd-demo-dev.yaml
                    sed -i'' "s#DOCKERHUB_NAMESPACE#$DOCKERHUB_NAMESPACE#" deploy/cicd-demo-dev.yaml
                    sed -i'' "s#APP_NAME#$APP_NAME#" deploy/cicd-demo-dev.yaml
                    sed -i'' "s#BUILD_NUMBER#$BUILD_NUMBER#" deploy/cicd-demo-dev.yaml
                    kubectl apply -f deploy/cicd-demo-dev.yaml
                '''
            }
        }
        stage('push with tag') {
            when {
                expression {
                    return params.TAG_NAME=~ /v.*/
                }
            }
            steps {
                input(id: 'release-image-with-tag', message: 'release image with tag?')
                withCredentials([usernamePassword(credentialsId: "$GIT_CREDENTIAL_ID", passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                    sh 'git config --global user.email "1546985126@qq.com" '
                    sh 'git config --global user.name "zhaoxiaoqiang" '
                    sh 'git tag -a $TAG_NAME -m "$TAG_NAME" '
                    sh 'git push http://$GIT_USERNAME:$GIT_PASSWORD@$GIT_REPO_URL/$GIT_ACCOUNT/k8s-cicd-demo.git --tags --ipv4'
                }
                sh 'docker tag $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:SNAPSHOT-$BUILD_NUMBER $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:$TAG_NAME'
                sh 'docker push $REGISTRY/$DOCKERHUB_NAMESPACE/$APP_NAME:$TAG_NAME'
            }
        }
        stage('deploy to production') {
            when {
                expression {
                    return params.TAG_NAME =~ /v.*/
                }
            }
            steps {
                input(id: 'deploy-to-production', message: 'deploy to production?')
                sh '''
                    sed -i'' "s#REGISTRY#$REGISTRY#" deploy/cide-demo.yaml
                    sed -i'' "s#DOCKERHUB_NAMESPACE#$DOCKERHUB_NAMESPACE#" deploy/cicd-demo.yaml
                    sed -i'' "s#APP_NAME#$APP_NAME#" deploy/cicd-demo.yaml
                    kubectl apply -f deploy/cicd-demo.yaml
                '''
            }
        }
    }
}