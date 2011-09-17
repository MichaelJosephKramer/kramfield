mongoose = require('mongoose')
WorkItem = require('./models/workItem')

mongoose.connect 'mongodb://localhost/kramfield_test'

instance = new WorkItem

instance.name = "finish mongo feature"
instance.number = "I5-544"
instance.description = "sample description to make me feel good"
instance.acceptanceCriteria = "As a dev I want this mongo thing done so I can make money"
instance.status = "in development"

instance.save (err) ->
  if !err
    console.log('Work Item Saved!!')

temp = "I5-544"

WorkItem.find { 'number': temp }, (err, docs) ->
  for wi in docs
    console.log 'number: ' + wi.number
    console.log 'name: ' + wi.name
    console.log 'acceptance: ' + wi.acceptanceCriteria
