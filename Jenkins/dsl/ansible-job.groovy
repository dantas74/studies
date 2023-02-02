def ansiblePath = build.environment.get('JENKINS_WORKSPACE') + '/ansible/'

job('ansible') {
  description('Update the html table based on input')

  parameters{
    choiceParam('AGE', ['21', '22', '23', '24', '25'])
  }

  steps {
    wrappers {
      colorizeOutput(colorMap = 'xterm')
    }

    ansiblePlaybook(ansiblePath + 'playbook.yml') {
      inventoryPath(ansiblePath + 'hosts')
      colorizedOutput(true)
      extraVars {
        extraVar('PEOPLE_AGE', '${AGE}', false)
      }
    }
  }
}
