# implement your job functions
myJobs =
  add: (a, b, callback) ->
    callback a + b

  succeed: (arg, callback) ->
    callback()

  fail: (arg, callback) ->
    callback new Error("fail")

# setup a worker
worker = require("coffee-resque").connect(
  host: redisHost
  port: redisPort
).worker("*", myJobs)


# some global event listeners

# triggered every time the worker polls
worker.on "poll", (worker, queue) ->

# triggered before a job is attempted
worker.on "job", (worker, queue, job) ->

# triggered every time a job errors
worker.on "error", (err, worker, queue, job) ->

# triggered on every successful job run
worker.on "success", (worker, queue, job, result) ->

worker.start()