# BlueGreen-Capstone-DevOpsNDG-Udacity
## History

<p> I was first made aware of DevOps culture by my team leader in my current company. I struggled to find resources online, but when I did, I was happy I stumbled upon this Nanodegree provided by Udacity. Initially when I started this nanodegree it was daunting and intimidating. Especially since I was unfamiliar with AWS, nor how DevOps solutions and culture work. </br>
<p>Initially, I intended to deploy this capstone project as part of my current work environment, but due to time constraints, I was unable to do what I wanted, so I opted to deploy a sample application instead.</br>

## Problems I faced
- My inexperience with Infrastructure, and networking first proved to be difficult to wrap my head around. But I managed to get things done in the IAC course, and this capstone    project as well.
- Another issue I faced, but got around to, was to properly get Jenkins to interact with EKS kubectl. I found a workaround to applying the config file as a secret file in Jenkins UI. All I did was write the bash scripts I used when I ran kubectl on my local host machine, and it worked as expected.

## What I Learned
- I learned how to use AWS
- Basic CloudFormation / Infrastructure as code
- Use Jenkins
- Use Docker
- Use kubernetes
- Green / Blue deployment
- EKS Clusters
- Pipeline architecture

## Tools Used
- Host OS: Windows 10
- VMWare Workstation
- Ubuntu 18.04 LTS
- AWS Cli
- Kubectl
- Python3
- Flask
- pip3
- Pylint
- Docker and DockerHub Repositories.
- Kubernetes
- AWS Management Console
- CloudFormation
- EC2
- EKS
- Jenkins
- GitHub

## Summary of Steps
We assume that we have a github and dockerhub accounts.
1. Spin up an EC2 to host our Jenkins server.
  1. Log into AWS management console.
  2. Search and find EC2.
  3. Choose appropriate AMI, storage and network (leave VPC as default as it allows internet access).
  4. Make sure to allow port 20 and 8080 to be open in Ingress Rules to allow for successful SSH (port 20) and communication for Jenkins (port 8080).
  5. Download/use the <keyPair>.pem.
  6. Wait for the machine provisioning.
2. SSH into the machine with the keypair provided during the EC2 spin up.
  1. Open local terminal, and 'cd' into the destination where the <keyPair>.pem is downloaded/exists.
  2. From AWS management console, select that you want to connect to the newly created machine, and copy the command.
  3. Paste the command into terminal.
3. Update and install the required prerequisites for Jenkins. (Assuming you have a Ubuntu image on your EC2 instance machine)
  'sudo apt-get update'
4. Install Jenkins using the following commands in EC2 machine's terminal:
  1. 'sudo apt install default-jdk'
  2. 'wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -'
  3. 'sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list''
  4. 'sudo apt update && sudo apt upgrade'
  5. 'sudo apt install jenkins'
  6. 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'
5. Install Docker.
  1. Follow [this link](https://docs.docker.com/engine/install/) to install docker according to your OS/Linux distro.
6. Add Jenkins to docker group.
  1. 'sudo groupadd docker'
  2. 'sudo gpasswd -a jenkins docker'
  3. 'sudo service restart docker'
  4. 'systemctl stop jenkins'
  5. 'systemctl start jenkins'
7. Log into your Jenkins server via AWS FQDN (fully qualified domain name) followed by ':8080'. Look at the URL in the below image:
  ![See here:!](/screenshots/myJenkinsServer.png "My Jenkins Server!")
  1. You will find that it asks you for a password, please refer to step 4.6.
  2. Install the recommended plugins.
8. From the left panel, pick manage jenkins>plugins and install the following:
  1. BlueOcean aggregator.
  2. AWS tools
  3. Kubernetes plugin.
9. Install AWS CLI [from here](https://aws.amazon.com/cli/#:~:text=The%20AWS%20Command%20Line%20Interface,and%20automate%20them%20through%20scripts.).
10. Back in the Jenkins EC2 machine terminal, install kubernetes CLI (kubectl) from [this link](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
11. Install Git, Python, and Pip (terminal):
  1. 'sudo apt install git-all'
  2. 'sudo apt-get update && sudo apt-get -y install python3-pip'
12. Use CloudFormation to deploy the VPC infra files. There are two ways of doing this:
  a. Through the CloudFormation gui.
    1. Open CloudFormation from AWS management console.
    2. Choose that you want to install from script.
    3. Pick the VPC you want to create from the InfrastructureScriptsCFN folder
    4. Make sure to name the outputs appropriately.
  b. Through bash commands on your host machine.
    1. Use the create.sh and update.sh scripts and run them through terminal to emulate the processes mentioned in 12.a.
13. From the AWS Management Console, create an EKS cluster.
14. After creating the cluster, remember its name, and open terminal on your local machine (not the jenkins terminal) and apply these commands:
  1. 'aws eks --region <the region where you created the cluster> update-kubeconfig --name <your cluster name>'
  2. 'kubectl config current-context'
15. Go back to CloudFormation and deploy your worker nodes. Same rules and method used in step 12.
16. Enable your worker nodes to join the EKS cluster by applying the auth.yml via this command
  1. 'kubectl apply -f ~/KubernetesScripts/aws-auth-cm.yaml'
  2. Run 'kubectl get nodes' You should get an output in the termianl detailing the worker nodes, their age, and status.
17. Apply both blue and green kubernetes services (outside pipeline as a test) by running: 
  'kubectl apply -f ~/KubernetesScripts/Blue/blue-service.yml && kubectl apply -f ~/KubernetesScripts/Blue/blue-template.yml'
18. If successful, run 'kubectl get all' You should get info where it details the ip/fqdn of the service/deployment showing that it is up and running.
19. Build Jenkins pipeline.
20. Profit!

**Note**: The scripts in the InfrastructureScriptsCFN folder are inspired by the AWS EKS documentation.
