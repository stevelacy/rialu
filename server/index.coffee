config = require "../config"
server = require "./httpserver"
require "./webapp.coffee"
require "./sockets.coffee"


server.listen config.port
console.log "Starting server on port #{config.port}"
