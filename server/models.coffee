mongoose = require 'mongoose'


userSchema = new mongoose.Schema
  username:
    type: String
    required: true
  twitter:
    type: String
    required: true

clientSchema = new mongoose.Schema
  nickname: 
    type: String
    required: true
  online:
    type: String
  user:
    type: String
    required: true
  os:
    type: String
    required: false

userSchema.set 'autoindex', false
clientSchema.set 'autoindex', false

exports.User = mongoose.model 'User', userSchema
exports.Client = mongoose.model 'Client', clientSchema
