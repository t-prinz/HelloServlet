# Example using OpenShift plugin with external Jenkins instance

This  example shows how to install the OpenShift plugin to an external Jenkins instance, i.e. - a Jenkins instance that was not deployed via the OpenShift Jenkins container image.

In this example, a Jenkins installation is performed inside of a RHEL 8 virtual machine.  From there, the Jenkins instance is configured to communicate with an OpenShift cluster.

References:
https://github.com/openshift/jenkins-client-plugin
https://www.jenkins.io/solutions/pipeline/
https://www.jenkins.io/doc/book/pipeline/syntax/

## Deploy a RHEL 8 virtual machine

* Provision a RHEL 8 system and update it (RHEL 8.5 was used for this example).

## Provision an OpenShift Sandbox cluster (if an existing OpenShift cluster is not available)

* Navigate to https://developers.redhat.com/developer-sandbox
* Click on Get Started
* Click on "Launch your Developer Sandbox for Red Hat OpenShift"
* Click on "Start using your sandbox"

## Download the OpenShift client for both the Jenkins server and your laptop

* Login to your OpenShift cluster using a web browser
* Click on the "?" button in the upper right hand corner and select "Command line tools"
* Download the Linux binary (for the Jenkins server) and the appropriate binary for your platform

## Obtain your OpenShift login token

* Click on your login name in the upper right hand corner and select "Copy login command"
* Click on Display Token
* Take note of your API token

## Obtain your OpenShift REST API URL and default project name

* Using the login command copied above, run it on your system where oc is installed.
* Once logged in, run the following command to obtain the cluster REST API URL:

`oc whoami --show-server`

* Run the following command to get your default project name (will be used later)

`oc project`

* For reference, you can retrieve your API token with the following command:

`oc whoami -t`

NOTE:  If you are using an OpenShift Sandbox cluster, then you will need to login to the cluster afer it idles down in order to get a new login token.

## Install Jenkins

The following Ansible playbook was used to perform the Jenkins installation:

`https://github.com/t-prinz/jenkins_playbooks/blob/main/install_jenkins.yml`

## Configure Jenkins with git and the OpenShift client if using the Jenkins server as an agent

In this example, the Jenkins server is used as the agent, so git needs to be installed as well as the OpenShift client (oc).  For this example, the following Ansible playbook was used to make these changes:  

`https://github.com/t-prinz/jenkins_playbooks/blob/main/configure_openshift_agent.yml`

## Install the OpenShift Jenkins plugin

* Download the Jenkins OpenShift client from https://updates.jenkins-ci.org/download/plugins/openshift-client/ (use version 1.0.35 as 1.0.37 did not work)
* Login to Jenkins in your browser and navigate to Manage Jenkins > Manage Plugins.
* Select the "Advanced" Tab.
* Find the "Deploy Plugin" HTML form and select the openshift-client.hpi from the previous steps.
* Deploy the file.
* Check the box that indicates Jenkins should be restarted. (Wait until restart is complete and log back in).

## Configure an OpenShift Cluster in Jenkins

* Navigate to Manage Jenkins -> Configure System and find the OpenShift Plug-in section
* Click on "Add OpenShift Cluster"
* Provide a name and the REST API URL
* Add a new credential.  For the "Kind" parameter, select "OpenShift Token for OpenShift Client Plugin."
* Provide your OpenShift login token
* Provide an ID, e.g. - ocp-credential
* Select the "Disable TLS Verify" option

## Create the Jenkinsfile

* Review the Jenkins file at https://github.com/t-prinz/HelloServlet.git
* Either clone this repository or copy this Jenkinsfile into your own repository
* Update the Jenkinsfile to include the name of your cluster (as defined above)

`openshift.withCluster('YOUR_CLUSTER_NAME') {`

* Update the Jenkinsfile to include the name of your default project (as found above)

`openshift.withProject('YOUR_DEFAULT_PROJECT_NAME') {`

* Commit and push the changes to the Jenkinsfile

## Define a new Multibranch Pipeline

* Login to Jenkins in your browser
* From the Dashboard, select "New Item"
* Enter a name, select "Multibranch Pipeline," and then "Okay"
* In the Branch Sources section, select "Add source" -> GitHub
* For the Repository HTTPS URL enter the name of the repository that has your Jenkinsfile
* Click on Validate
* Click on Save

## Execute the Pipeline

* From the Jenkins Dashboard, select your Pipeline
* Click on master
* Click on Build Now
* Click on the build number
* Click on Console Output

The pipeline should run successfully and show the service accounts.
