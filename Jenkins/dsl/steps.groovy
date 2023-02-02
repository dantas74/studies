job('steps-dsl') {
  steps {
    shell('''
    echo "Hello, World!"
    echo "Running Script"
    /opt/scripts/dummy.sh
    ''')
  }
}
