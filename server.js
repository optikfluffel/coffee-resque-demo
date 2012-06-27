//express.js Stuff
var express = require('express');
var app = express.createServer(express.logger());

//Redis Stuff
var redis = require("redis"),
  client = redis.createClient();

//Coffee-Resque Stuff
var resque = require('coffee-resque').connect({
  redis: redis
});

//GET /
app.get('/', function(request, response) {
  response.send('Hello World!');
});

//Configuration
var port = process.env.PORT || 5000;
app.set('port', port);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');

//Start listening
app.listen(port, function() {
  console.log("Listening on " + port);
});