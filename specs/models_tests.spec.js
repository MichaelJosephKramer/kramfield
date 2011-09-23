(function() {
  var WorkItem, mongoose;
  mongoose = require('mongoose');
  WorkItem = require('../models/workItem').WorkItem;
  mongoose.connect('mongodb://localhost:58467/kramfield_test');
  describe('with none of the require fields filled in', function() {
    var error;
    error = null;
    beforeEach(function() {
      var workItem;
      workItem = new WorkItem();
      workItem.save(function(err) {
        error = err;
        return asyncSpecDone();
      });
      return asyncSpecWait();
    });
    return it('should fail validation', function() {
      console.log(error);
      return expect(error).toBeNull;
    });
  });
  describe('with all its required fields filled in', function() {
    var error;
    error = null;
    beforeEach(function() {
      var workItem;
      workItem = new WorkItem();
      workItem.Name = "this better fucking work";
      workItem.Number = "55";
      workItem.save(function(err) {
        error = err;
        return asyncSpecDone();
      });
      return asyncSpecWait();
    });
    return it('should fail validation', function() {
      return expect(error).toBeNull;
    });
  });
}).call(this);
