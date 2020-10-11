# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath="abayman/udacitydevopscapstone-legacy"

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
sudo docker login &&\
    sudo docker image tag udacitydevopscapstone $dockerpath

# Step 3:
# Push image to a docker repository
sudo docker image push $dockerpath
