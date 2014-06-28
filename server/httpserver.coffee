http = require 'http'
app = require './express'
config = require '../config'

server = require("http").Server app
module.exports = server
