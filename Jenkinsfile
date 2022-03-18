pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'id'
                sh 'oc version'
                script {
                    openshift.withCluster('ocpsandbox') {
                        openshift.withProject() {
                            def saSelector1 = openshift.selector( "serviceaccount" )
                            saSelector1.describe()
                        }
                    }
                }
            }
        }
    }
}
