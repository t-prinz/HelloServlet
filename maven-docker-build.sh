#!/bin/bash

# Use maven to build the war file

mvn package

# Build the EAP container

podman build -t quay.io/tprinz/helloworld-eap:latest -f Dockerfile-EAP .

# Push the EAP container to the Quay repository

podman push quay.io/tprinz/helloworld-eap:latest

# Run the EAP container

podman run --name helloworld-eap -d --rm -p 8080:8080 quay.io/tprinz/helloworld-eap:latest

echo "********"
echo "Access the EAP container at http://localhost:8080"
echo "********"

# Build the JWS container

podman build -t quay.io/tprinz/helloworld-jws:latest -f Dockerfile-JWS .

# Push the JWS container to the Quay repository

podman push quay.io/tprinz/helloworld-jws:latest

# Run the JWS container

podman run --name helloworld-jws -d --rm -p 8081:8080 quay.io/tprinz/helloworld-jws:latest

echo "********"
echo "Access the JWS container at http://localhost:8081/HelloServlet-1.0.0"
echo "********"
