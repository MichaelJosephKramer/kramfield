task 'deploy', 'deploy to heroku', ->
  {exec} = require 'child_process'
  exec 'git push heroku master --porcelain', (error, stdout, stderr) ->
    console.log "error: #{error}"
    console.log "stdout: #{stdout}"
    console.log "stderr: #{stderr}"

task 'spawn', 'deploy to heroku', ->
  spawn = require('child_process').spawn
  spawn 'git push heroku master'
