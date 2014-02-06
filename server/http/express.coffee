path = require "path"
express = require "express"
stylus = require "stylus"
config = require "../config"
sessionStore = require "./sessionstore"
passport = require "./passport"

app = express() 

compile = (str, path) ->
  stylus(str).set("filename", path)

app.configure () ->
  app.set "view engine", "jade"
  app.set "views", path.join process.cwd(), "views"
  app.use stylus.middleware
    src: path.join process.cwd(), "static"
    compile:compile
  app.use express.static path.join process.cwd(), "static"
  app.use express.json()
  app.use express.urlencoded()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session({
    store: sessionStore
    key: "express.sid"
    secret: config.cookieSecret
    })
  app.use passport.initialize()
  app.use passport.session()




module.exports = app