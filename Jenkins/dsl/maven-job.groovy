job('maven') {
  description('Maven DSL job')

  scm {
    git('https://github.com/jenkins-docs/simple-java-maven-app', 'master', { node -> node / 'extensions' << '' })
  }

  steps {
    maven {
      mavenInstallation('mvn-jenkins')
      goals('-B -DskipTests clean package')
    }

    maven {
      mavenInstallation('mvn-jenkins')
      goals('test')
    }

    shell('''
    Running Java application
    java -jar $JENKINS_WORKSPACE/target/my-app-1..0-SNAPSHOT.jar
    ''')
  }

  publishers {
    archiveArtifacts('target/*.jar')
    archiveJunit('target/surefire-reports/*.xml')
    mailer('matheus-dr@proton.me', true, true)
  }
}
