job('job-with-parameters') {
  parameters{
    stringParam('PLANET', defaultValue = 'Earth', description = 'The planet to be selected for the job')
    booleanParam('FLAG', true)
    choiceParam('OPTION', ['option1 (default)', 'option2', 'option3'])
  }
}
