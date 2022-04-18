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

### Build and deploy the EAP container

    cp Dockerfile-EAP Dockerfile
    git add Dockerfile
    git commit Dockerfile -m "temporarily specify Dockerfile"
    git push origin master
    oc new-app --name=helloworld-eap https://github.com/t-prinz/HelloServlet.git --strategy=docker
    oc expose svc/helloworld-eap
    git rm Dockerfile
    git commit Dockerfile -m "remove temporary Dockerfile"
    git push origin master

Follow the logs and wait until the buid finishes

`oc logs -f buildconfig/helloworld-eap`

Get the route to the application

`oc get route helloworld-eap`

The URL to visit will be

    http://<your-route>/HelloServlet-1.0.0

Delete all of the OpenShift resources

`oc delete all --all`

### Build and deploy the JWS container

    cp Dockerfile-JWS Dockerfile
    git add Dockerfile
    git commit Dockerfile -m "temporarily specify Dockerfile"
    git push origin master
    oc new-app --name=helloworld-jws https://github.com/t-prinz/HelloServlet.git --strategy=docker
    oc expose svc/helloworld-jws
    git rm Dockerfile
    git commit Dockerfile -m "remove temporary Dockerfile"
    git push origin master

Follow the logs and wait until the buid finishes

`oc logs -f buildconfig/helloworld-jws`

Get the route to the application

`oc get route helloworld-jws`

The URL to visit will be

    http://<your-route>/HelloServlet-1.0.0

Delete all of the OpenShift resources

`oc delete all --all`

## OpenShift Source-to-Image (S2I) build

### Use OpenShift build this application using an EAP template

Find the available EAP templates

`oc new-app --search --template=eap`

Get the parameters for the template

`oc new-app --search --template=eap73-basic-s2i --output=yaml`

Create the application

`oc new-app --template=eap73-basic-s2i --param=APPLICATION_NAME=helloworld-eap --param=SOURCE_REPOSITORY_URL=https://github.com/t-prinz/HelloServlet.git --param=SOURCE_REPOSITORY_REF=master --param=CONTEXT_DIR=""`

As before, follow the logs and wait until the build finishes.  Then get the route to the application; the URL to visit will be

    http://<your-route>/HelloServlet-1.0.0

Delete all of the OpenShift resources

`oc delete all --all`

### Use OpenShift to build this application using a Java Web Server (JWS) template

Find the available JWS templates

`oc new-app --search --template=jws`

Get the parameters for the template used in this example (the template name may be slightly different)

`oc new-app --search --template=jws53-openjdk11-tomcat9-basic-s2i --output=yaml`

Create the application

`oc new-app --template=jws53-openjdk11-tomcat9-basic-s2i --param=APPLICATION_NAME=helloworld-jws --param=SOURCE_REPOSITORY_URL=https://github.com/t-prinz/HelloServlet.git --param=SOURCE_REPOSITORY_REF=master --param=CONTEXT_DIR=""`

As before, follow the logs and wait until the build finishes.  Then get the route to the application; the URL to visit will be

    http://<your-route>/HelloServlet-1.0.0

Delete all of the OpenShift resources

`oc delete all --all`

### Use OpenShift to build this application using a base EAP image

    oc new-app --name=helloworld-eap registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7~https://github.com/t-prinz/HelloServlet.git
    oc expose svc/helloworld-eap

### Use OpenShift to build this application using a base JWS image

    oc new-app --name=helloworld-jws registry.redhat.io/jboss-webserver-5/webserver54-openjdk8-tomcat9-openshift-rhel8~https://github.com/t-prinz/HelloServlet.git
    oc expose svc/helloworld-jws

Below is a work in progress

## Deploy the application from a container image

### Deploy the pre-built Docker EAP image to OpenShift

    oc new-app --name=helloworld-eap --docker-image=quay.io/tprinz/helloworld-eap:latest
    oc expose svc/helloworld-eap

### Deploy the pre-built Docker JWS image to OpenShift

    oc new-app --name=helloworld-jws --docker-image=quay.io/tprinz/helloworld-jws:latest
    oc expose svc/helloworld-jws

### Additional method
# HelloServlet

## 1. Create project

```sh
oc new-project helloservlet --display-name="HelloServlet Demo"
```

## 2. Deploy binary artifact

```sh
oc new-app --name=myapp jboss-webserver30-tomcat8-openshift:1.2~https://github.com/ecwpz91/HelloServlet.git
```

## 3. Expose service

```sh
oc expose svc/myapp
```

## 4. Set environment variable dynamically

```sh
oc set env dc/myapp -e ENVAR=W00t!
```

## 5. Create a base64 password

```sh
python -c "import base64; import hashlib; import getpass; print(base64.b64encode(hashlib.sha1(str.encode(getpass.getpass())).digest()))"
```

## 6. Create secret.json

```sh
cat <<EOF >secret.json
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
type: Opaque 
data:
  password: ${BASE64_PASSWORD}
EOF
```
## 7. Create secret

```sh
oc create -f secret.json
```


# References

https://docs.openshift.com/container-platform/3.11/dev_guide/dev_tutorials/binary_builds.html
https://docs.openshift.com/online/pro/using_images/s2i_images/java.html#s2i-images-java-deploy-applications
http://v1.uncontained.io/playbooks/app_dev/binary_deployment_howto.html
https://access.redhat.com/documentation/fr-fr/red_hat_jboss_web_server/5.5/html-single/red_hat_jboss_web_server_for_openshift#Create-an-OpenShift-application-using-existing-maven-binaries
