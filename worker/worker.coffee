# Redis Stuff
redis = require("redis")
redisClient = redis.createClient()

# Coffee-Resque Stuff
resque = require 'coffee-resque'
connection = resque.connect
  redis: redisClient

# Helper for making the worker stop when the queue is empty
class NonPollingWorker extends resque.Worker
  pause: -> @end()

# implement your job functions
myJobs =
  wait: (time, callback) ->
    setTimeout ( ->
      callback()
    ), time

  succeed: (arg, callback) ->
    callback()

  fail: (arg, callback) ->
    callback new Error("fail")

# setup a worker
worker = new NonPollingWorker connection, "*", myJobs

# some global event listeners
#
# triggered every time the worker polls
worker.on "poll", (worker, queue) ->

# triggered before a job is attempted
worker.on "job", (worker, queue, job) ->

# triggered every time a job errors
worker.on "error", (err, worker, queue, job) ->

# triggered on every successful job run
worker.on "success", (worker, queue, job, result) ->
  redisClient.publish "pubsub", "success"

@start = ->
  worker.start()