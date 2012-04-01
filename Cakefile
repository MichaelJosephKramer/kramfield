{exec} = require 'child_process'

task 'deploy', 'deploy to heroku', ->
  console.log 'Deploying to heroku. Wait for it...'
  console.log "*****************************************************"

  exec 'git push heroku master --porcelain', (error, stdout, stderr) ->
    console.log "error: #{error}" unless not error
    console.log ""
    console.log "The Deployment:"
    console.log "*****************************************************"
    console.log stdout
    if stderr
      console.log "The deets:"
      console.log "*****************************************************"
      console.log stderr
