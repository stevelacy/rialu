mongoose = require 'mongoose'
passport = require "passport"
TwitterStrategy = require("passport-twitter").Strategy

db = require '../db'
config = require '../config'

User = db.models.User


handleFunction = (token, tokenSecret, profile, cb) ->
  User.findOne {twitter: profile.id}, (err, user) ->
    return cb err if err?
    #icon = profile._json.profile_image_url_https.replace('_normal', '')
    icon = profile._json.profile_image_url_https
    profileUpdate =
      username: profile._json.screen_name
      icon: icon
      twitter: String profile._json.id
    if user?
      user.set profileUpdate
      user.save cb
    else
      User.create profileUpdate, (err, doc) ->
        return cb err if err?
        cb null, doc

strategy = new TwitterStrategy
  consumerKey: config.keys.twitterKey
  consumerSecret: config.keys.twitterSecret
  callbackURL: config.twitterCallback
, handleFunction

passport.use strategy

passport.serializeUser (user, cb) ->
  cb null, user.twitter

passport.deserializeUser (id, cb) ->
  User.findOne {twitter: id}, cb


module.exports = passport
