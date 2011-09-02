(function() {
  var api, github, sys;
  sys = require('sys');
  api = require('github').GitHubApi;
  github = new api(true);
  github.getUserApi().getFollowers('timwingfield', function(err, followers) {
    return console.log(followers.join('\n'));
  });
  github.getCommitApi().getBranchCommits('MichaelJosephKramer', 'Config', 'master', function(err, commits) {
    return console.log(commits);
  });
}).call(this);
