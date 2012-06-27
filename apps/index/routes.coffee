routes = (app) ->

  # GET /
  app.get "/", (request, response) ->
    response.render "#{__dirname}/views/index",
      title: "Coffee-Resque Demo"

module.exports = routes