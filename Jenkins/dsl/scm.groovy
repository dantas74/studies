job('job-with-scm') {
  scm {
    git('http://gitlab/dev/maven', 'master')
  }
}
