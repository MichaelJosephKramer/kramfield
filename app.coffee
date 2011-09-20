express = require('express')
sys = require('sys')
api = require('github').GitHubApi
mongoose = require('mongoose')
coffeekup = require('coffeekup')

github = new api true
WorkItem = require('../../../models/workItem')

mongoose.connect 'mongodb://localhost/kramfield'

app = module.exports = express.createServer

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'coffee'
  app.register '.coffee', coffeekup.adapters.express
  app.use express.bodyParser
  app.use express.methodOverride
  app.use app.router
  app.use(express.static(__dirname + '/public'))

app.configure 'development', ->
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

app.configure 'production', ->
  app.use express.errorHandler

app.get '/', (req, res) ->
  github.authenticateToken('MichaelJosephKramer', '2ef9f58c0b8ee2332d07a8fc399b8e23')
  github.getCommitApi().getBranchCommits 'MichaelJosephKramer', 'kramfield', 'master', (err, commits) ->
    render 'index', {title: 'kramfield', commits: commits}

get '/workitem': ->
  WorkItem.find {}, (err, docs) ->
    console.log docs
    render 'workitem/index', {title: 'Manage Work Items', workitems: docs}

get '/workitem/new': ->
  render 'workitem/new', {title: 'New Work Item', message: 'all is well'}

post '/workitem/new': ->
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
