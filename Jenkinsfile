pipeline {
    environment{
        registryCredential = 'dockerCreds' 
        greenDockerImage = '' 
        blueDockerImage = ''
        legacyDockerImage = ''
    }
    agent any 
    stages {
        stage('Install Requirements'){
            steps{
                sh "pip3 install -r req.txt"
            }
        }

        stage('Lint Code'){
            steps {
                sh "bash ./run-lint.sh"
            }
        }

        stage('Build Legacy Docker Image') {
            steps {
                script{
                    legacyDockerImage = docker.build "abayman/udacitydevopscapstone-legacy"
                }
            }
        }

        stage('Upload Legacy'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        legacyDockerImage.push()
                    }
                }
            }
        }

        stage('Clear Local Image'){
            steps{
                sh "docker image rm abayman/udacitydevopscapstone-legacy:latest"
            }
        }

        stage('Set K8S Context'){
            steps {
                withAWS(region:'us-west-2', credentials:'awsLogin'){
                    sh '''
                        rm ~/.kube/config
                        aws eks --region us-west-2 update-kubeconfig --name myCluster
                        kubectl config current-context
                    '''
                }
            }
        }

        stage('Deploy Legacy Image') {
            steps {
                withAWS(credentials:'awsLogin') {
                    sh '''
                        kubectl apply -f initial-deployment/initial-template.yml && kubectl apply -f initial-deployment/initial-service.yml
                    '''
                }
            }
        }

        stage('Build & Deploy Green?')
        {
            steps{
                input "Proceed with Green build and Deployment?"
            }
        }

        stage('Build Green Docker Image') {
            steps {
                script{
                    greenDockerImage = docker.build "abayman/udacitydevopscapstone-green"
                }
            }
        }

        stage('Upload Green'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        greenDockerImage.push()
                    }
                }
            }
        }

        stage('Clear Local Green Image'){
            steps{
                sh "docker image rm abayman/udacitydevopscapstone-green:latest"
            }
        }

        stage('Deploy Green Image') {
            steps {
                withAWS(credentials:'awsLogin') {
                    sh '''
                        kubectl apply -f KubernetesScripts/Green/green-template.yml && kubectl apply -f KubernetesScripts/Green/green-service.yml
                    '''
                }
            }
        }

        stage('Build & Deploy Blue?')
        {
            steps{
                input "Proceed with blue build and Deployment?"
            }
        }

        stage('Build Blue Docker Image') {
            steps {
                script{
                    blueDockerImage = docker.build "abayman/udacitydevopscapstone-blue"
                }
            }
        }

        stage('Upload Blue'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        blueDockerImage.push()
                    }
                }
            }
        }

        stage('Clear Local Blue Image'){
            steps{
                sh "docker image rm abayman/udacitydevopscapstone-blue:latest"
            }
        }

        stage('Deploy Blue Image') {
            steps {
                withAWS(credentials:'awsLogin') {
                    sh '''
                        kubectl apply -f KubernetesScripts/Blue/blue-template.yml && kubectl apply -f KubernetesScripts/Blue/blue-service.yml
                    '''
                }
            }
        }
       
    }
}