mongoose = require 'mongoose'
passport = require "passport"
TwitterStrategy = require("passport-twitter").Strategy

db = require './db'
config = require '../config'

User = db.models.User


handleFunction = (token, tokenSecret, profile, cb) ->
  User.findOne {id: profile.id}, (err, user) ->
    return cb err if err?
    #image = profile._json.profile_image_url_https.replace('_normal', '')
    image = profile._json.profile_image_url_https
    profileUpdate =
      id: Number profile.id
      username: profile.username
      image: image
    if user?
      user.set profileUpdate
      user.save cb
    else
      User.create profileUpdate, (err, doc) ->
        return cb err if err?
        cb null, doc

strategy = new TwitterStrategy
  consumerKey: config.keys.twitter.key
  consumerSecret: config.keys.twitter.secret
  callbackURL: config.twitter.callbackUrl
, handleFunction

passport.use strategy

passport.serializeUser (user, cb) ->
  cb null, user._id

passport.deserializeUser (id, cb) ->
  User.findOne {_id: id}, cb


module.exports = passport
