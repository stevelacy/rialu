db = require "./db"
app = require "./express"
config = require "../config"
passport = require "./passport"

Computer = db.models.Computer
Mobile = db.models.Mobile
User = db.models.User

app.get "/", (req, res) ->
  return res.redirect "/login" unless req.user?
  res.render "index", config: config

app.get "/login", (req, res) ->
  res.render "login", config: config



## Passport authentication
app.get "/auth/twitter", passport.authenticate "twitter"
app.get "/auth/twitter/callback",
  passport.authenticate "twitter",
    successRedirect: "/"
    falureRedirect: "/login"

##
