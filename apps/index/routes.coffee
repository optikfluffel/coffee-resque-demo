io = require("socket.io").listen(8080)

routes = (app) ->

  # GET /
  app.get "/", (request, response) ->
    response.render "#{__dirname}/views/index",
      title: "Coffee-Resque Demo"

  # POST /add
  app.post "/add", (request, response) ->
    response.redirect "/"

  # POST /start
  app.post "/start", (request, response) ->
    response.redirect "/"

  # Socket
  io.sockets.on "connection", (socket) ->
    socket.emit "news",
      hello: "world"

    socket.on "my other event", (data) ->
      console.log data

module.exports = routes