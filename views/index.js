(function() {
  var commit, _i, _len, _ref;
  h1(this.title);
  _ref = this.commits;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    commit = _ref[_i];
    div(function() {
      span(function() {
        return commit.author.name;
      });
      span(function() {
        return " -- ";
      });
      return span(function() {
        return commit.message;
      });
    });
  }
}).call(this);
