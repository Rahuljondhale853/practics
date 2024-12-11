#!/bin/bash
 
# Variables
#REPO_DIR="/path/to/your/repo"
IMAGE_NAME="practics"
CONTAINER_NAME="nodejsapp"
 
# Pull the latest code
echo "Pulling the latest code from the repository..."
#cd $REPO_DIR || { echo "Repository directory not found! Exiting."; exit 1; }
git pull
 
# Get the latest commit ID
COMMIT_ID=$(git rev-parse --short HEAD)
echo "Latest commit ID: $COMMIT_ID"
 
# Build the new Docker image with the commit ID as the tag
echo "Building the Docker image..."
docker build -t $IMAGE_NAME:$COMMIT_ID .
 
# Stop and remove the current running container
echo "Stopping and removing the current container..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
 
# Run a new container with the updated image
echo "Running a new container with the updated image..."
docker run -d -p 3000:3000 --name $CONTAINER_NAME $IMAGE_NAME:$COMMIT_ID
 
echo "Deployment completed successfully!"

