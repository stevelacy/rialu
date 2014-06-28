keys = require "./keys"

module.exports =
  name: "Rialu"
  port: 5003
  mongo:
    host: "127.0.0.1"
    port: "27017"
    name: "rialu2"
    url: "mongodb://127.0.0.1:27017/rialu2"
  session:
    name: "express.sid"
    secret: "b1d8d68e863cbbf5b6eac491ad52972d2e8559369c34a5add78913eab3d9fa3d"
  keys: keys
  twitter:
    callbackUrl: "/auth/twitter/callback"
  gcm:
    retries: 3
