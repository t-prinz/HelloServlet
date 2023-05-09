#FROM registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7
#FROM registry.redhat.io/jboss-eap-7/eap74-openjdk11-openshift-rhel8:7.4.10-3
FROM registry.access.redhat.com/ubi8/openjdk-17

#COPY target/HelloServlet-1.0.0.war /opt/eap/standalone/deployments
COPY target/ROOT.war /opt/eap/standalone/deployments

EXPOSE 8080
EXPOSE 8443

#CMD [“/opt/eap/bin/openshift-launch.sh”, “run”]
CMD /opt/eap/bin/openshift-launch.sh run
