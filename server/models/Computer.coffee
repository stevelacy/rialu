mongoose = require "mongoose"
Schema = mongoose.Schema

Computer = new Schema
  macaddr:
    type: String
    required: true
  nickname:
    type: String
    required: true
  online:
    type: Boolean
    default: false
  os:
    type: String

Computer.set "autoindex", false

module.exports = Computer
