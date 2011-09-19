for workitem in @workitems
  div ->
    span "Work item: #{workitem.name} (#{workitem.number})"

p ->
  a href: '/workitem/new', -> 'Add a new Work item'
