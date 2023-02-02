pipeline {
  agent any

  stages {
    stage('Test') {
      steps {
        sh 'echo "failing :("; exit 1'
      }
    }
  }

  post{
    always {
      echo 'On all builds'
    }

    success {
      echo 'Only successful builds'
    }

    failure {
      echo 'Only failed builds'
    }

    unstable {
      echo 'Only unstable builds'
    }
  }
}
