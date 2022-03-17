pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'echo hello'
                sh 'id'
                sh 'echo $PATH'
                sh 'oc version'
            }
        }
    }
}
