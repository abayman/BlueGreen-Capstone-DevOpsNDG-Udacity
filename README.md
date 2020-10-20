# BlueGreen-Capstone-DevOpsNDG-Udacity
## History

<p> I was first made aware of DevOps culture by my team leader in my current company. I struggled to find resources online, but when I did, I was happy I stumbled upon this Nanodegree provided by Udacity. Initially when I started this nanodegree it was daunting and intimidating. Especially since I was unfamiliar with AWS, nor how DevOps solutions and culture work. </br>
<p>Initially, I intended to deploy this capstone project as part of my current work environment, but due to time constraints, I was unable to do what I wanted, so I opted to deploy a sample application instead.</br>

## Problems I faced
- My inexperience with Infrastructure, and networking first proved to be difficult to wrap my head around. But I managed to get things done in the IAC course, and this capstone    project as well.
- Another issue I faced was 
- Final issue I faced, but got around to, was to properly get Jenkins to interact with EKS kubectl. I found a workaround to applying the config file as a secret file in Jenkins UI. All I did was write the bash scripts I used when I ran kubectl on my local host machine, and it worked as expected.

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
2. SSH into the machine with the keypair provided during the EC2 spin up.
3. Update and install the required prerequisites for Jenkins.
4. Install Jenkins.
5. Install Docker.
6. Add Jenkins to docker group.
7. Install AWS CLI.
8. Install kubernetes CLI.
10. Install Git, Python, and Pip
11. Use CloudFormation to deploy the VPC infra files.
12. From the AWS Management Console, create an EKS cluster.
13. Go back to CloudFormation and deploy your worker nodes.
14. Apply the authentication yml file to kubernetes via kubectl.
15. Configure context for kubernetes cluster.
16. Build Jenkins pipeline.
17. Profit!

**Note**: The scripts in the InfrastructureScriptsCFN folder are inspired by the AWS EKS documentation.
