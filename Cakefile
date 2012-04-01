{exec} = require 'child_process'

task 'deploy', 'deploy to heroku', ->
  console.log "*****************************************************"
  console.log 'Deploying to heroku. Wait for it...'
  console.log "*****************************************************"

  exec 'git push heroku master --porcelain', (error, stdout, stderr) ->
    console.log "error: #{error}" unless error == null
    console.log "*****************************************************"
    console.log "The Deployment:"
    console.log stdout
    console.log stderr
    if stderr
      console.log "*****************************************************"
      console.log "The deets:"
      console.log stderr
