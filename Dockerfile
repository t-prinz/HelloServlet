FROM registry.redhat.io/jboss-webserver-5/webserver54-openjdk8-tomcat9-openshift-rhel8

COPY target/HelloServlet-1.0.0.war /deployments

EXPOSE 8080
EXPOSE 8443
