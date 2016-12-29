require 'slack-ruby-client'

Slack.configure do |conf|
  # 先ほど控えておいたAPI Tokenをセット
  conf.token = 'xoxb-121387490661-93aFvEFsTkvh7JKgX4VhfziF'
end

# RTM Clientのインスタンスを生成
client = Slack::RealTime::Client.new

# hello eventを受け取った時の処理
client.on :hello do
  puts 'connected!'
end

# message eventを受け取った時の処理
client.on :message do |data|
  case data['text']
  when "おなかすいた" then
    client.message channel: data['channel'], text: "<@#{data['user']}>さん\n<@yogoken>さんが一緒に食べる人探しています!!\n ■オススメのお店3選\n→吉野家: https://tabelog.com/tokyo/A1301/A130102/13194113/\n→小洞天: https://retty.me/area/PRE13/ARE2/SUB202/100000011274/\n→麺屋ひょっとこ: https://retty.me/area/PRE13/ARE2/SUB202/100000018958/\n■場所\n5Fエレベーター前\n■待ち合わせ時間\n2分後"
    students << "<@#{data['user']}>"
  when /^bot/ then
    client.message channel: data['channel'], text: "Sorry <@#{data['user']}>, what?"
  when 'ご飯食べたい人一覧' then
    client.message channel: data['channel'], text: "いきたい人を呼び出す"
  end
end

# Slackに接続
client.start!
