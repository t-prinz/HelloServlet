#!/bin/bash

# Build the container

docker build -t quay.io/tprinz/dockereap:latest -f ../Dockerfile

# Push the container to the Quay repository

docker push quay.io/tprinz/dockereap:latest

# Run the container

docker run --name dockereap -d --rm -p 8080:8080 quay.io/tprinz/dockereap:latest
