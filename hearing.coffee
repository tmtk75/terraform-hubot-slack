module.exports = (robot) ->
  robot.hear /smile/i, (msg) ->
      msg.send "http://www.onix-ns.com/blog/misato/waraiotoko.gif"

  robot.hear /^beer$/i, (msg) ->
      msg.send ":beer:"
