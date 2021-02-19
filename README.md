# HelloServlet

Sample Java web application that can be deployed to OpenShift using EAP or Java Web Server (JWS)

To have OpenShift build this application using a Java Web Server (JWS) template

Find the available JWS templates

oc new-app --search --template=jws

Get the parameters for the template

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
