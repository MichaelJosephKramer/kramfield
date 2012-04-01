task 'deploy', 'deploy to heroku', ->
  {exec} = require 'child_process'
  exec 'git push heroku master --porcelain', (error, stdout, stderr) ->
    console.log "error: #{error}" unless error == null
    console.log stdout
    console.log stderr #{stderr}"
