(function() {
  var WorkItem, api, app, coffeecup, express, github, mongoose, sys;
  express = require('express');
  sys = require('sys');
  api = require('github').GitHubApi;
  mongoose = require('mongoose');
  coffeecup = require('coffeecup');
  github = new api(true);
  WorkItem = require('./models/workItem');
  mongoose.connect('mongodb://localhost/kramfield');
  app = module.exports = express.createServer();
  app.configure(function() {
    app.set('views', __dirname + '/views');
    app.set('view engine', 'coffee');
    app.register('.coffee', coffeecup.adapters.express);
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    return app.use(express.static(__dirname + '/public'));
  });
  app.configure('development', function() {
    return app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  });
  app.configure('production', function() {
    return app.use(express.errorHandler());
  });
  app.get('/', function(req, res) {
    github.authenticateToken('MichaelJosephKramer', '2ef9f58c0b8ee2332d07a8fc399b8e23');
    return github.getCommitApi().getBranchCommits('MichaelJosephKramer', 'kramfield', 'master', function(err, commits) {
      return res.render('index', {
        title: 'kramfield',
        commits: commits
      });
    });
  });
  app.get('/workitem', function(req, res) {
    return WorkItem.find({}, function(err, docs) {
      console.log(docs);
      return res.render('workitem/index', {
        title: 'Manage Work Items',
        workitems: docs
      });
    });
  });
  app.get('/workitem/new', function(req, res) {
    return res.render('workitem/new', {
      title: 'New Work Item',
      message: 'all is well'
    });
  });
  app.post('/workitem/new', function(req, res) {
    var workItem;
    workItem = new WorkItem;
    workItem.name = req.body.name;
    workItem.number = req.body.number;
    workItem.description = req.body.description;
    workItem.acceptanceCriteria = req.body.acceptanceCriteria;
    workItem.status = req.body.status;
    return workItem.save(function(err) {
      if (err) {
        return res.render('workitem/new', {
          title: 'New Work Item',
          message: "Oh shit, couldn't save " + workItem.name + "."
        });
      } else {
        return res.render('workitem/new', {
          title: 'New Work Item',
          message: "" + workItem.name + " saved!"
        });
      }
    });
  });
  app.listen(3000);
  console.log("Express server is listening on port fucking %d in %s mode.", app.address().port, app.settings.env);
}).call(this);
