h1 @title

p @message

div ->
  form action: '/workitem/new', method: 'post', ->
    h3 'new work item'

    div class: 'field', ->
      span "Name: "
      input id: 'name', name: 'name'

    div class: 'field', ->
      span "Number: "
      input id: 'number', name: 'number'

    div class: 'field', ->
      span "Description: "
      input id: 'description', name: 'description'

    div class: 'field', ->
      span "Acceptance Criteria: "
      input id: 'acceptanceCriteria', name: 'acceptanceCriteria'

    div class: 'field', ->
      span "Status: "
      input id: 'status', name: 'status'

    div class: 'field', ->
      span "&nbsp;"
      input type: 'submit', value: 'Save'
