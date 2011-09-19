@app = require('zappa') ->

  configure ->
    use 'bodyParser', 'methodOverride', app.router, 'static'

  configure
    development: -> use errorHandler: {dumpExceptions: on, showStack: on}
    production: -> use 'errorHandler'

  get '/': ->
    api = require('github').GitHubApi
    github = new api(true)
    github.authenticateToken('MichaelJosephKramer', '2ef9f58c0b8ee2332d07a8fc399b8e23')
    github.getCommitApi().getBranchCommits 'MichaelJosephKramer', 'kramfield', 'master', (err, commits) ->
      render 'index', {title: 'kramfield', commits: commits}

  get '/workitem': ->
    mongoose = require('mongoose')
    WorkItem = require('../../../models/workItem')

    mongoose.connect 'mongodb://localhost/kramfield'

    WorkItem.find {}, (err, docs) ->
      console.log docs
      render 'workitem/index', {title: 'Manage Work Items', workitems: docs}

  get '/workitem/new': ->
    render 'workitem/new', {title: 'New Work Item', message: 'all is well'}

  post '/workitem/new': ->
    mongoose = require('mongoose')
    WorkItem = require('../../../models/workItem')

    mongoose.connect 'mongodb://localhost/kramfield'

    workItem = new WorkItem
    workItem.name = request.body.name
    workItem.number = request.body.number
    workItem.description = request.body.description
    workItem.acceptanceCriteria = request.body.acceptanceCriteria
    workItem.status = request.body.status

    workItem.save (err) ->
      if err
        render 'workitem/new', {title: 'New Work Item', message: "Oh shit, couldn't save #{workItem.name}."}
      else
        render 'workitem/new', {title: 'New Work Item', message: "#{workItem.name} saved!"}
