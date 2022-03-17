References:
https://github.com/openshift/jenkins-client-plugin

1.  Download Jenkins OpenShift client (1.0.35) from https://updates.jenkins-ci.org/download/plugins/openshift-client/
NOTE:  1.0.37 did not work for me.
Open Jenkins in your browser, and navigate (as an administrator):
Manage Jenkins > Manage Plugins.
Select the "Advanced" Tab.
Find the "Deploy Plugin" HTML form and select the openshift-client.hpi from the previous steps.
Deploy the file.
Check that Jenkins should be restarted (Wait until restart is complete and log back in).

Provision an OpenShift Sandbox cluster
Navigate to https://developers.redhat.com/developer-sandbox
Click on Get Started
Clock on "Launch your Developer Sandbox for Red Hat OpenShift"
Click on "Start using your sandbox"

If the command line tools are not installed
Click on the "?" button in the upper right hand corner and select "Command line tools"
Download the appropriate binary for your platform

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
