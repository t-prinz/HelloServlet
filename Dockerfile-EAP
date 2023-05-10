#
# Reference:  https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.0/html-single/using_the_red_hat_jboss_enterprise_application_platform_docker_image/index#deploying_applications
#
# Note from reference:
#
# In the JBoss EAP container, JBoss EAP runs as the jboss user but copied files are brought in as root.
#
#FROM registry.redhat.io/jboss-eap-7/eap74-openjdk11-openshift-rhel8:latest
FROM registry.redhat.io/jboss-eap-7/eap74-openjdk8-openshift-rhel8:latest

ARG WAR_FILE=ROOT.war

COPY target/$WAR_FILE $JBOSS_HOME/standalone/deployments

USER root
RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/$WAR_FILE
USER jboss

#EXPOSE 8080
#EXPOSE 8443

##CMD [“/opt/eap/bin/openshift-launch.sh”, “run”]
#CMD /opt/eap/bin/openshift-launch.sh run
