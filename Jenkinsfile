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
                            def bcSelector = openshift.selector( "buildconfig/helloworld-jws" )
                            bc.Selector.describe()
                        }
                    }
                }
            }
        }
    }
}
