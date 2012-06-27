routes = (app) ->

  # GET /
  app.get "/", (request, response) ->
    response.render "#{__dirname}/views/index",
      title: "Coffee-Resque Demo"

  # POST /add
  app.post "/add", (request, response) ->
    response.redirect "/"

  #POST /start
  app.post "/start", (request, response) ->
    response.redirect "/"

module.exports = routes