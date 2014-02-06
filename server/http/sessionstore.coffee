sessionstore = require "sessionstore"
express = require "express"
config = require "../config"
app = express()

module.exports = sessionstore.createSessionStore
  type: "mongoDb"
  host: config.mongo.host # optional
  port: config.mongo.port # optional
  dbName: config.mongo.sessionDb # optional
  collectionName: "sessions" # optional
