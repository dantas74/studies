job('job-mailer') {
  publishers {
    mailer('matheus-dr@proton.me.com', true, true)
  }
}
