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
    child_process = require('child_process')
    command = "sudo /home/hnlq_sysu/ss-bash/ssadmin.sh #{com}"

    msg.send "This is the command #{command}."

    child_process.exec command, (error, stdout, stderr) ->
      if error
        msg.send stderr
      else
        msg.send stdout

    command = "sudo ssh root@139.59.220.183 /root/ss-bash/ssadmin.sh #{com}"

    msg.send "This is the command #{command}."

    child_process.exec command, (error, stdout, stderr) ->
      if error
        msg.send stderr
      else
        msg.send stdout
