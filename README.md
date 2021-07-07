# HelloServlet - Containerized Java Application Example

This example shows several different ways to containerize a sample Java web application using either EAP or Java Web Server (JWS).  Three methods of deployment are shown:

1.  Manual build:  In this scenario, the war file is manually built (the war file can be built with mvn or with javac).  Once the war file is built, a container image is built using the supplied Dockerfile.  From there, the container image is tagged and pushed to your container registry.
2.  OpenShift Docker build:  In this scenario, the war file is manually built (like with the Manual build).  Once the war file is built, a container image is built by OpenShift using the supplied Dockerfile.  
3.  OpenShift Source-to-Image (S2I) build:  In this scenario, OpenShift builds the container image starting with the application source code.  In this case, no manual build is required and the supplied Dockerfile is not used.

## Prerequisites

* Maven along with a JDK
* The docker CLI and runtime (or podman if you are using RHEL)
* Access to a container registry, such as https://quay.io
* Access to an OpenShift cluster
* The oc CLI from the OpenShift cluster

## Manual build

Run the following script to create and run the application using both EAP and JWS containers.  The script will build the application using maven, build the container image, push the container image, and run the application.

`./maven-docker-build.sh`

The script will print a message showing how to access each application.

## General OpenShift Information

OpenShift provides various templates and base images that can be used to build and deploy an application.  As the name implies, when performing a build using a base image, OpenShift uses this as the base image that would be specified in a Dockerfile (i.e. - what is specified with the FROM directive in a Dockerfile).  A template provides a way to deploy an application that may contain more than one container image and specify parameters that affect the build and deployment.

To list all local templates and image streams, use:

`oc new-app -L`

## OpenShift Docker build

This method uses the war file that was previously built along with the Dockerfile in this repository.  When specifying a docker build strategy, OpenShift looks for a file named Dockerfile in the repository, hence the copying of the EAP and JWS Dockerfiles.  There is probably a better way to do this.

Build and deploy the EAP container

cp Dockerfile-EAP Dockerfile
git add Dockerfile
git commit Dockerfile -m "temporarily specify Dockerfile"
git push origin master
oc new-app --name=helloworld-eap https://github.com/t-prinz/HelloServlet.git --strategy=docker
oc expose svc/helloworld-eap
rm Dockerfile

Build and deploy the JWS container

cp Dockerfile-JWS Dockerfile
git add Dockerfile
git commit Dockerfile -m "temporarily specify Dockerfile"
git push origin master
oc new-app --name=helloworld-jws https://github.com/t-prinz/HelloServlet.git --strategy=docker
oc expose svc/helloworld-jws
rm Dockerfile


## OpenShift Source-to-Image (S2I) build

### To have OpenShift build this application using a Java Web Server (JWS) template


Find the available JWS templates

`oc new-app --search --template=jws`

Get the parameters for the template used in this example

oc new-app --search --template=jws50-tomcat9-basic-s2i --output=yaml

Create the application

oc new-app --template=jws50-tomcat9-basic-s2i --param=APPLICATION_NAME=tprinzjws --param=SOURCE_REPOSITORY_URL=https://github.com/t-prinz/HelloServlet.git --param=SOURCE_REPOSITORY_REF=master --param=CONTEXT_DIR=""

Once built, navigate to the route but append /HelloServlet-1.0.0 to the URL

To have OpenShift build this application using an EAP template

Find the available EAP templates

oc new-app --search --template=eap

Get the parameters for the template

oc new-app --search --template=eap72-basic-s2i --output=yaml

Create the application

oc new-app --template=eap72-basic-s2i --param=APPLICATION_NAME=tprinzeap --param=SOURCE_REPOSITORY_URL=https://github.com/t-prinz/HelloServlet.git --param=SOURCE_REPOSITORY_REF=master --param=CONTEXT_DIR=""

Once built, navigate to the route but append /HelloServlet-1.0.0 to the URL

EAP is using
image-registry.openshift-image-registry.svc:5000/openshift/jboss-eap72-openshift@sha256:e78f3020712cf12dc04dfd325e5c4759c298cd1b805f4920a4f41995d469bb0d

JWS is using
image-registry.openshift-image-registry.svc:5000/openshift/jboss-webserver50-tomcat9-openshift@sha256:2a13f1f97a7c58242e3a7dfe57a614764b8b3970015a2f0f29aa8d74c38e5caf

Deploying using a base EAP image

oc new-app --name=tprinzeaps2i registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7~https://github.com/t-prinz/HelloServlet.git
oc expose svc/tprinzeaps2i

Deploying using a base JWS image

oc new-app --name=tprinzjwss2i registry.redhat.io/jboss-webserver-5/webserver54-openjdk8-tomcat9-openshift-rhel8~https://github.com/t-prinz/HelloServlet.git
oc expose svc/tprinzjwss2i

Manually building a Docker image



Access the application at

http://localhost:8080/HelloServlet-1.0.0/

Run the docker image

oc new-app --name=dockereap --docker-image=quay.io/tprinz/dockereap:latest

Use OpenShift s2i to build the app using the Docker file

