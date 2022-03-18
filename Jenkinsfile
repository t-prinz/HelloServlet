pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'id'
                sh 'oc version'
                script {
                    openshift.withCluster('ocpsandbox') {
                        openshift.withProject('tprinz-dev') {
                            def saSelector1 = openshift.selector( "serviceaccount" )
                            saSelector1.describe()
                            openshift.selector( 'deployment/helloworld-jws' ).describe()

                            def buildSelector = openshift.selector( 'buildconfig/helloworld-jws' )
                            buildSelector.describe()
                        }
                    }
                }
            }
        }
    }
}
