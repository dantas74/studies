pipeline {
  agent any

  environment {
    SECRET = credentials('seccret-text')
  }

  stages {
    stage('Build') {
      steps {
        sh 'echo $SECRET'
      }
    }
  }
}
