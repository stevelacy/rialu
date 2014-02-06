io = require 'socket.io'
express = require 'express'
mongoose = require 'mongoose'
passportSocketIo = require 'passport.socketio'
sessionStore = require './sessionstore'


config = require '../config'
db = require '../db'
server = require './httpserver'

io = io.listen server

Client = db.models.Client




onAuthorizeSuccess = (data, accept) ->
  console.log "successful connection to socket.io"
  accept null, true
  return
onAuthorizeFail = (data, message, error, accept) ->
  console.log "failed connection to socket.io:", message
  accept null, true
  return

io.set "authorization", passportSocketIo.authorize
  cookieParser: express.cookieParser
  key: "express.sid"
  secret: config.cookieSecret
  store: sessionStore
  success: onAuthorizeSuccess
  fail: onAuthorizeFail




io.on 'connection', (socket) ->
  return console.log 'socket error - user not authorized' unless socket.handshake.user?
  user = socket.handshake.user
  console.log "the user handshake is #{JSON.stringify user}"

  socket.emit 'connect', {connect: "connect"}
  if user
    room = user.twitter
    socket.join room
    console.log "the browser room is #{ JSON.stringify room}"
    ###
    Client.find {user:room}, (err, client) ->
      return console.log err if err? 
      if client?
        socket.emit 'clients', {client}
    ###

  else
    room = ''
    socket.join room

  socket.on 'auth', (auth) ->
    console.log "auth #{JSON.stringify auth}"
    room = auth.auth
    socket.join room
    socket.twitter = room
    socket.nickname = auth.nickname
    socket.emit 'auth', {auth:auth.auth}
    Client.findOne {nickname:auth.nickname, user: room}, (err, client) ->
      return console.log err if err?
      clientData = 
        nickname: auth.nickname
        os: auth.os
        online: true
        user: room

      if client
        client.set clientData
        client.save
          success: ->
            console.log "Client saved"
          error: ->
            console.log "Client saved error"
      else
        Client.create clientData, (err, client) ->
          return err if err?
          console.log "client created #{client.nickname}"

  socket.on 'disconnect', (data) ->
    Client.findOneAndUpdate {nickname:socket.nickname, user: socket.twitter}, {online: false}, (err, client) ->
      console.log err if err?



  socket.on 'panic', (panic) ->
    socket.broadcast.to(socket.twitter).emit 'panic', {panic:panic, client:panic.client}
    
  socket.on 'volume', (volume) ->
    socket.broadcast.to(socket.twitter).emit 'volume', {volume:volume.volume, client:volume.client}

  socket.on 'lock', (lock) ->
    socket.broadcast.to(socket.twitter).emit 'lock', {lock:lock, client:lock.client}

  socket.on 'horn', (horn) ->
    socket.broadcast.to(socket.twitter).emit 'horn', {horn:horn, client:horn.client}

  socket.on 'command', (command) ->
    socket.broadcast.to(socket.twitter).emit 'command', {command:command.command, client:command.client}

    
  socket.on 'keyboard', (keyboard) ->
    socket.broadcast.to(socket.twitter).emit 'keyboard', {keyboard:keyboard, client:keyboard.client}

  socket.on 'gps', (gps) ->
    socket.broadcast.to(socket.twitter).emit 'gps', {gps:gps, client:gps.client}

  socket.on 'reply', (reply) ->
    socket.broadcast.to(socket.twitter).emit 'reply', {reply:reply, client:reply.client}

  socket.on 'delete', (del) ->
    console.log  del.delete
    id = mongoose.Types.ObjectId del.delete
    console.log id
    Client.findByIdAndRemove id, (err, del) ->
      return console.log err if err?

