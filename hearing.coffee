module.exports = (robot) ->
  robot.hear /smile/i, (msg) ->
      msg.send "http://image.rakuten.co.jp/cereza/cabinet/cospa2/7242-410-2.jpg"

  robot.hear /^beer$/i, (msg) ->
      msg.send ":beer:"
