task 'deploy', 'deploy to heroku', ->
  {exec} = require 'child_process'
  exec 'git push heroku master', (error, stdout, stderr) ->
    console.log "error: #{error}"
    console.log "stdout: #{stdout}"
    console.log "stderr: #{stderr}"
