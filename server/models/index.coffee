mongoose = require "mongoose"

exports.User = mongoose.model "User", require "./User"
exports.Computer = mongoose.model "Computer", require "./Computer"
exports.Mobile = mongoose.model "Mobile", require "./Mobile"
