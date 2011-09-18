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

  get '/workitem': ->
    render 'workitem/index', {title: 'Manage Work Items'}

  get '/workitem/new': ->
    render 'workitem/new', {title: 'New Work Item', message: 'all is well'}

  post '/workitem/new': ->
    mongoose = require('mongoose')
    WorkItem = require('../../../models/workItem')

    mongoose.connect 'mongodb://localhost/kramfield'

    workItem = new WorkItem
    workItem.name = request.body.name
    workItem.number = request.body.number
    
    @name = request.body.name
    @message = "#{@name} saved!"

    console.log "@name var: " + @name
    console.log "workItem.name: " + workItem.name

    workItem.save (err) ->
      if err
        @message = "Oh shit, couldn't save #{@name}"

    render 'workitem/new', {title: 'New Work Item', message: "#{@message}"}
