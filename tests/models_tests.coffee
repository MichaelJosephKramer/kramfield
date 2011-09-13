mongoose = require('mongoose')
WorkItem = require('../models/workItem').WorkItem

mongoose.connect 'mongodb://localhost/kramfield_test'

describe 'WorkItem', ->
  describe 'with none of the require fields filled in', ->

    it 'should fail validation', ->
      workItem = new WorkItem()
      error = null

      workItem.save (err) ->
        error = err
        asyncSpecDone()

      expect(error).not.toBeNull
      asyncSepcWait()
