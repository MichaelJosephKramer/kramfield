console.log 'included'
mongoose = require('mongoose')
Schema = mongoose.Schema

workItemSchema = new Schema name: { type: String, required: true }
  , number: { type: String, required: true}
  , description: { type: String, required: false }
  , acceptanceCriteria: { type: String, required: false }
  , status: { type: String, required: false}

mongoose.model 'WorkItem', workItemSchema
module.exports = mongoose.model 'WorkItem'
#root = exports ? window
#root.WorkItem = mongoose.model 'WorkItem'
#WorkItem = mongoose.model 'WorkItem', workItemSchema
