# Socket.io Stuff
io = require("socket.io").listen(8080)

# Redis Stuff
redis = require("redis")
redisClient = redis.createClient()

# Coffee-Resque Stuff
resque = require("coffee-resque").connect(redis: redisClient)
worker = require '../../worker/worker'

routes = (app) ->
  # GET /
  app.get "/", (request, response) ->
    response.render "#{__dirname}/views/index",
      title: "Coffee-Resque Demo"

  # Socket
  io.sockets.on "connection", (socket) ->
    sub = redis.createClient()
    sub.subscribe "pubsub"
    
    sub.on "message", (channel, message) ->
      redisClient.llen "resque:queue:queue", (error, length) ->
        redisClient.lrange "resque:queue:queue", 0, length, (error, objects) ->
          socket.emit "update",
            jobs: objects
    
    # Handle 'Add new Job' button
    socket.on "add", (message) ->
      resque.enqueue('queue', 'wait', [message.wait])
      redisClient.publish "pubsub", "new"

    # Handle 'Start Worker' button
    socket.on "start", (message) ->
      worker.start()

    socket.on "disconnect", ->
      sub.unsubscribe "pubsub"
      sub.quit()

module.exports = routes