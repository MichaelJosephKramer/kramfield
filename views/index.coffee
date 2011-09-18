h1 @title
div class: 'sample', ->
  a href: 'workitem/', -> 'Manage work items'
for commit in @commits
  div ->
    span ->
      commit.author.name
    span ->
      " -- "
    span ->
      commit.message
