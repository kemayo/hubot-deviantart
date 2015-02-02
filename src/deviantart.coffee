# Description
#   A hubot script that searches DeviantArt
#
# Configuration:
#
# Commands:
#   hubot deviation me <query> - fetch an image related to the query
#
# Notes:
#
# Author:
#   David Lynch <kemayo@gmail.com>

x2j = require 'xml2json'

module.exports = (robot) ->

  robot.respond /(?:deviate|deviantart|deviation) me ?(.+)?/, (msg) ->
    robot.http("http://backend.deviantart.com/rss.xml?type=deviation&q=boost%3Apopular+max_age%3A168h+#{encodeURIComponent(msg.match[1] or '')}&limit=10")
          .get() (err, res, body) ->
            response = x2j.toJson(body, object: true)
            if response.rss and response.rss.channel and response.rss.channel.item and response.rss.channel.item.length
              msg.reply msg.random(response.rss.channel.item).link
            else
              msg.reply "Nothing found"