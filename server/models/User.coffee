mongoose = require "mongoose"

User = new mongoose.Schema
  username:
    type: String
    required: true
  id:
    type: Number
    required: true
  name:
    type: String
  token:
    type: String
  tokenSecret:
    type: String
  description:
    type: String
  location:
    type: String
  image:
    type: String
  provider:
    type: String

User.set "autoindex", false

module.exports = User
