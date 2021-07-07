FROM registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7

COPY target/HelloServlet-1.0.0.war /opt/eap/standalone/deployments

EXPOSE 8080
EXPOSE 8443

#CMD [“/opt/eap/bin/openshift-launch.sh”, “run”]
CMD /opt/eap/bin/openshift-launch.sh run
