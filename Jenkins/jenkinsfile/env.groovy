pipeline {
  agent any

  environment {
    NAME = 'Matheus'
    LAST_NAME = 'Dantas Ricardo'
  }

  stages {
    stage('Build') {
      steps {
        sh 'echo "$NAME $LAST_NAME"'
      }
    }
  }
}
