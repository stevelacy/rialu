mongoose = require "mongoose"

exports.User = mongoose.model "User", require "./User"
exports.Device = mongoose.model "Device", require "./Device"
