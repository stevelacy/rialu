keys = require "./keys"

module.exports = 
  url: "http://node.la"
  domain: "node.la"
  port: 5002
  keys:
    twitterKey: keys.twitterKey
    twitterSecret: keys.twitterSecret
  mongo:
    url: "mongodb://127.0.0.1:27017/rialu"
    host: "127.0.0.1"
    port: 27017
    sessionDb: "rialu-session"
  cookieSecret: "k28798456798447856749867398"
  twitterCallback: "http://node.la/auth/twitter/callback"
  session:
    key: "express.sid"