robot.hear /(https:\/\/gyazo\.com\/\S+)/i, (msg) ->
  url = msg.match[1] + ".png"
  robot.emit 'slack.attachment',
    channel: msg.envelope.message.room
    content:
      author_name: "Gyazo"
      image_url: url
