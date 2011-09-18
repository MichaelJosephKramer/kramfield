(function() {
  var api, github, sys;
  sys = require('sys');
  api = require('github').GitHubApi;
  github = new api(true);
  this.app = require('zappa')(function() {
    configure(function() {
      return use('bodyParser', 'methodOverride', app.router, 'static');
    });
    configure({
      development: function() {
        return use({
          errorHandler: {
            dumpExceptions: true,
            showStack: true
          }
        });
      },
      production: function() {
        return use('errorHandler');
      }
    });
    return get({
      '/': function() {
        api = require('github').GitHubApi;
        github = new api(true);
        return github.getCommitApi().getBranchCommits('MichaelJosephKramer', 'Config', 'master', function(err, commits) {
          return render('index', {
            title: 'kramfield',
            commits: commits
          });
        });
      }
    });
  });
}).call(this);
