// express.js Stuff
var express = require('express');
var app = express.createServer(express.logger());

// Require Coffee-Script
require('coffee-script');

// Redis Stuff
var redis = require("redis"),
  client = redis.createClient();

// Coffee-Resque Stuff
var resque = require('coffee-resque').connect({
  redis: redis
});

// Configuration
var port = process.env.PORT || 5000;
app.set('port', port);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');

// Set public folder for static files
app.use(express.static(__dirname + '/public'));

// Routes
require('./apps/index/routes')(app)

// Start listening
app.listen(port, function() {
  console.log("Listening on " + port);
});