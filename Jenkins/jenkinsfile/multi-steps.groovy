pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh 'echo "Hello, World!"'

        sh '''
          echo "Another Hello, World!"
          ls -lah
        '''
      }
    }
  }
}
