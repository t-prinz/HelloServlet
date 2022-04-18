pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'id'
                sh 'oc version'
                sh 'which mvn'
                sh 'which git'
                sh 'pwd'
                sh 'ls -alF'
                sh 'mvn clean'
                sh 'mvn package'
                sh 'mkdir -p ocp_bin_build/deployments'
                sh 'cp target/HelloServlet-1.0.0.war ocp_bin_build/deployments/ROOT.war'
                sh 'ls -alF ocp_bin_build'
                script {
                    openshift.withCluster('ocpsandbox') {
                        openshift.withProject('tprinz-dev') {
                            def saSelector1 = openshift.selector( "serviceaccount" )
                            saSelector1.describe()

                        }
                    }
                }
            }
        }
    }
}
