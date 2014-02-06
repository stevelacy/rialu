http = require 'http'
app = require './express'
config = require '../config'

server = http.createServer(app).listen config.port

module.exports = server