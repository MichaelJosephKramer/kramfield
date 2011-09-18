h1 @title
for commit in @commits
  div ->
    span ->
      commit.author.name
    span ->
      " -- "  
    span ->
      commit.message
