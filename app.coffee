@app = require('zappa') ->

  configure ->
    use 'bodyParser', 'methodOverride', app.router, 'static'

  configure
    development: -> use errorHandler: {dumpExceptions: on, showStack: on}
    production: -> use 'errorHandler'

  get '/': ->
    api = require('github').GitHubApi
    github = new api(true)
    github.getCommitApi().getBranchCommits 'MichaelJosephKramer', 'Config', 'master', (err, commits) ->
      render 'index', {title: 'kramfield', commits: commits}
