pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                openshift.withCluster() {
                }
                sh 'echo hello'
                sh 'id'
                sh 'echo $PATH'
                sh 'oc version'
            }
        }
    }
}
