pipeline {
    environment{
        registryCredential = 'docker_creds' 
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
                sh "bash ./run_pylint.sh"
            }
        }

        stage('Set K8S Context'){
            steps {
                withAWS(credentials:'awsLogin'){
                    sh "kubectl config set-context arn:aws:eks:us-west-2:423240894622:cluster/myCluster"
                }
            }
        }

        stage('Build Green Docker Image') {
            steps {
                script{
                    greenDockerImage = docker.build "abayman/udacitydevopscapstone-legacy01"
                }
            }
        }

        stage('Upload Green Image to Docker-Hub'){
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        greenDockerImage.push()
                    }
                }
            }
        }
}