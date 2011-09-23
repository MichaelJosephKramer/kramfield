express = require('express')
sys = require('sys')
api = require('github').GitHubApi
mongoose = require('mongoose')
coffeekup = require('coffeekup')

github = new api true
WorkItem = require('./models/workItem')

mongoose.connect 'mongodb://localhost/kramfield'

app = module.exports = express.createServer()


app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'coffee'
  app.register '.coffee', coffeekup.adapters.express
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use(express.static(__dirname + '/public'))

app.configure 'development', ->
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

app.configure 'production', ->
  app.use express.errorHandler()

app.get '/', (req, res) ->
  github.authenticateToken('MichaelJosephKramer', '2ef9f58c0b8ee2332d07a8fc399b8e23')
  github.getCommitApi().getBranchCommits 'MichaelJosephKramer', 'kramfield', 'master', (err, commits) ->
    res.render 'index', {title: 'kramfield', commits: commits}

app.get '/workitem', (req, res) ->
  WorkItem.find {}, (err, docs) ->
    console.log docs
    res.render 'workitem/index', {title: 'Manage Work Items', workitems: docs}

app.get '/workitem/new', (req, res) ->
  res.render 'workitem/new', {title: 'New Work Item', message: 'all is well'}

app.post '/workitem/new', (req, res) ->
  workItem = new WorkItem
  workItem.name = req.body.name
  workItem.number = req.body.number
  workItem.description = req.body.description
  workItem.acceptanceCriteria = req.body.acceptanceCriteria
  workItem.status = req.body.status

  workItem.save (err) ->
    if err
      res.render 'workitem/new', {title: 'New Work Item', message: "Oh shit, couldn't save #{workItem.name}."}
    else
      res.render 'workitem/new', {title: 'New Work Item', message: "#{workItem.name} saved!"}

app.listen 3000
console.log "Express server is listening on port fucking %d in %s mode.", app.address().port, app.settings.env
