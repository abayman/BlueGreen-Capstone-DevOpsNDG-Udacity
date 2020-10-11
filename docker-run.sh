# Step 1:
# Build image and add a descriptive tag
sudo docker build --tag=udacitydevopscapstone-legacy .

# Step 2: 
# List docker images
sudo docker image ls

# Step 3: 
# Run flask app
sudo docker run -d -p 5000:5000 udacitydevopscapstone-legacy
