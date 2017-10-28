# Description:
#   Reddit integration with Hubot.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot ss [command]
#
# Author:
#   EnriqueVidal


module.exports = (robot)->
module.exports = (robot) ->
 robot.respond /ss (.*)$/i, (msg) ->
    com = msg.match[1]
    @exec = require('child_process').exec
    command = "/root/ss-bash/ssadmin.sh #{com}"

    msg.send "Looking #{com}..."
    msg.send "This is the command #{command}."

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
      msg.send stderr

    command = "ssh root@139.59.220.183 /root/ss-bash/ssadmin.sh #{com}"

    msg.send "This is the command #{command}."

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
      msg.send stderr
