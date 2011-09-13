
/**
 * Module dependencies.
 */

var express = require('express');
var sys = require('sys');
var api = require('github').GitHubApi;
var github = new api(true);

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 
});

app.configure('production', function(){
  app.use(express.errorHandler()); 
});

// Routes

app.get('/', function(req, res){
  github.authenticateToken('MichaelJosephKramer', '2ef9f58c0b8ee2332d07a8fc399b8e23')
  github.getCommitApi().getBranchCommits('MichaelJosephKramer', 'kramfield', 'master', function(err, commits) {
    res.render('index', {
      title: 'Express'
      , commits: commits
    });
  });
});

app.listen(3000);
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
