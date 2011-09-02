sys = require('sys')
api = require('github').GitHubApi
github = new api(true)

github.getUserApi().getFollowers 'timwingfield', (err, followers) ->
  console.log followers.join '\n'

github.getCommitApi().getBranchCommits 'MichaelJosephKramer', 'Config', 'master', (err, commits) ->
  console.log commits
