function Person () {}

Person.prototype.say = function () {
  print('jslint is cool.');
}

var cooldaemon = new Person;
cooldaemon.say();
