mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

workItemSchema = new Schema name: { type: String, required: true }
  , number: { type: String, required: true}
  , description: { type: String, required: false }
  , acceptanceCriteria: { type: String, required: false }
  , status: { type: String, required: false}

mongoose.model 'WorkItem', workItemSchema
WorkItem = mongoose.model 'WorkItem'
