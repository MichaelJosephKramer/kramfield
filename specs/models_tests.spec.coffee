mongoose = require('mongoose')
{WorkItem} = require('../models/workItem')

mongoose.connect 'mongodb://localhost:58467/kramfield_test'

describe 'with none of the require fields filled in', ->
  error = null

  beforeEach ->
    workItem = new WorkItem()
    workItem.save (err) ->
      error = err
      asyncSpecDone()

    asyncSpecWait()

  it 'should fail validation', ->
    console.log error
    expect(error).toBeNull

describe 'with all its required fields filled in', ->
  error = null

  beforeEach ->
    workItem = new WorkItem()
    workItem.Name = "this better fucking work"
    workItem.Number = "55"

    workItem.save (err) ->
      error = err
      asyncSpecDone()

    asyncSpecWait()

  it 'should fail validation', ->
    expect(error).toBeNull
