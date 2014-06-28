mongoose = require "mongoose"
Schema = mongoose.Schema

Mobile = new Schema
  gcmId:
    type: String
    required: true
  number:
    type: String
    required: true
  key:
    type: String
  panic:
    type: Boolean
    default: false


Mobile.set "autoindex", false

module.exports = Mobile
