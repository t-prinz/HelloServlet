# Example using OpenShift plugin with external Jenkins instance

This  example shows how to install the OpenShift plugin to an external Jenkins instance, meaning a Jenkins instance that was not deployed via the OpenShift Jenkins container image.

In this example, a basic Jenkins installation is performed inside of a stock RHEL 8 virtual machine.  From there, the Jenkins instance is configured to communicate with an OpenShift cluster.

References:
https://github.com/openshift/jenkins-client-plugin

## Deploy a RHEL 8 virtual machine

Provision a RHEL 8 system and update it (RHEL 8.5 was used for this example).

## Provision an OpenShift Sandbox cluster (if an existing OpenShift cluster is not available)

Navigate to https://developers.redhat.com/developer-sandbox
Click on Get Started
Click on "Launch your Developer Sandbox for Red Hat OpenShift"
Click on "Start using your sandbox"

## Download the OpenShift client for both the Jenkins server and your laptop

Login to your OpenShift cluster using a web browser
Click on the "?" button in the upper right hand corner and select "Command line tools"
Download the Linux binary (for the Jenkins server) and the appropriate binary for your platform

## Install Jenkins

The following Ansible playbook was used to perform the Jenkins installation:

## Install the OpenShift Jenkins plugin

* Download Jenkins OpenShift client (use version 1.0.35 as 1.0.37 did not work) from https://updates.jenkins-ci.org/download/plugins/openshift-client/
* Open Jenkins in your browser, and navigate to Manage Jenkins > Manage Plugins.
* Select the "Advanced" Tab.
* Find the "Deploy Plugin" HTML form and select the openshift-client.hpi from the previous steps.
* Deploy the file.
* Check the box that indicates Jenkins should be restarted. (Wait until restart is complete and log back in).





Obtain your OpenShift login token
Click on your login name in the upper right hand corner and select "Copy login command"
Clock on Display Token
Take note of your API token
Copy the login command and and run it on your system where oc is installed in order to login to the OpenShift cluster.  Once logged in, run the following command to obtain the cluster REST API URL:

oc whoami --show-server

For reference, you can retrieve your API token with the following command:

oc whoami -t

Configure an OpenShift Cluster in Jenkins using the following:

https://github.com/openshift/jenkins-client-plugin#configuring-an-openshift-cluster

Click on "Add OpenShift Cluster"
Provide a name and the API URL
Add a new credential.  For the "Kind" parameter, select "OpenShift Token for OpenShift Client Plugin."
Provide your OpenShift login token
Provide an ID
Select the "Disable TLS Verify" option


Define a new Multibranch Pipeline Item
