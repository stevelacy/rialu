io = require "socket.io"
cookieParser = require 'cookie-parser'
sessionStore = require './sessionstore'
passportSocketIO = require 'passport.socketio'
server = require "./httpserver"
config = require "../config"

io = io.listen server


io.set 'authorization', passportSocketIO.authorize
  cookieParser: cookieParser
  key: config.session.name
  secret: config.session.secret
  store: sessionStore
  fail: (data, message, critical, accept) ->
    console.log 'io session failed'
    accept null, false
  success: (data, accept) ->
    console.log 'io session success'
    accept null, true



io.sockets.on "connection", (socket) ->
  console.log socket


module.exports = io