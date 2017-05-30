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
#   hubot reddit me <subreddit> [limit] - Returns results from subreddit.
#
# Author:
#   EnriqueVidal

lookup_site = "https://www.reddit.com/"

module.exports = (robot)->
  robot.respond /reddit (\S*)\s*(\S*)\s*(\S*)/i, (message)->
    lookup_reddit message, (text)->
      message.send text

  lookup_reddit = (message, response_handler)->
    top     = parseInt message.match[2]
    after = message.match[3]

    reddit  = "r/" + message.match[1] + ".json?limit=#{top}&after=#{after}"

    location  = lookup_site + reddit

    message.http( location ).get() (error, response, body)->
      return response_handler "Sorry, something went wrong"                      if error
      return response_handler "Reddit doesn't know what you're talking about"    if response.statusCode == 404
      return response_handler "Reddit doesn't want anyone to go there any more." if response.statusCode == 403

      body  = JSON.parse( body )
      list = body.data.children
      after = body.data.after
      response_handler after 

      for item in list
        title = item.data.title || item.data.link_title
        url = item.data.url || item.data.link_url

        text = "#{title} - #{url}"
        response_handler text
        response_handler item.data.body_html