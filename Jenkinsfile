pipeline {
    environment{
        registryCredential = 'dockerCreds' 
        greenDockerImage = '' 
        blueDockerImage = ''
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

        stage('Build Green Docker Image') {
            steps {
                script{
                    greenDockerImage = docker.build "abayman/udacitydevopscapstone-legacy"
                }
            }
        }

        stage('Upload Legacy'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        greenDockerImage.push()
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
                        aws eks --region us-east-2 update-kubeconfig --name myCluster
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
       
    }
}