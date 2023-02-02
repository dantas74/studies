pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        retry(3) {
          sh 'echoo "This is not working"'
        }
      }
    }
  }
}
