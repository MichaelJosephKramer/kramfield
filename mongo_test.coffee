mongoose = require('mongoose')
Schema = mongoose.Schema

Person = new Schema name: String
  , nickname: String

MyPerson = mongoose.model 'Person', Person

mongoose.connect 'mongodb://localhost/kramfield_test'

instance = new MyPerson

instance.name = 'Spongebob'
instance.nickname = 'Yellow and Porous'

instance.save (err) ->
  if !err
    console.log('Saved!!')

instance.name = 'Spongebob'
instance.nickname = 'spongey guy'

instance.save (err) ->
  if !err
    console.log('Saved!!')

temp = 'Spongebob'
  
MyPerson.find { 'name': temp }, (err, docs) ->
  for person in docs
    console.log person.nickname
