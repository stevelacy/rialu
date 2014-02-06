
express = require "./http/express"
sockets = require "./http/sockets"
config = require './config'
webapp = require "./http/webapp"
server = require "./http/httpserver"

console.log "Starting on port #{config.port}"