jobPipeline('docker-complete-maven') {
  def repo = 'https://github.com/matheus-dr/my-stack.git'
  def sshRepo = 'git@github.com:matheus-dr/my-stack.git'
  
  description('A complete example of a full working Jenkinsfile and DSL creation')
  keepDependencies(false)

  properties {
    githubProjectUrl(repo)

    rebuild {
      autoRebuild(false)
    }
  }

  definition {
    cpsCms {
      scm {
        git {
          remote { url(sshRepo) }
          branches('master')
          scriptPath('Jenkins/complete-example/jenkins/Jenkinsfile')
          extensions { }
        }
      }
    }
  }
}
