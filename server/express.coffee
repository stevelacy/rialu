path = require "path"
stylus = require "stylus"
express = require "express"
session = require "express-session"
bodyParser = require "body-parser"
cookieParser = require "cookie-parser"

config = require "../config"
passport = require "./passport"
sessionStore = require "./sessionstore"

app = express()
app.use stylus.middleware
  src: path.resolve __dirname, "../static"
  compile: (str, path) ->
    stylus str 
      .set "filename", path
app.use express.static path.resolve __dirname, "../static"
app.set "views", path.resolve __dirname, "../views"
app.set "view engine", "jade"
app.use cookieParser()
app.use bodyParser()
app.use session
  store: sessionStore
  name: config.session.name
  secret: config.session.secret
  cookie:
    expires: new Date Date.now() + 3600000
    maxAge: 3600000

app.use passport.initialize()
app.use passport.session()

module.exports = app
