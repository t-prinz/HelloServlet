pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'id'
                sh 'oc version'
                sh 'which mvn'
                sh 'which git'
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
