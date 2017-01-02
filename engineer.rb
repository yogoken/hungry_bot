require 'slack-ruby-client'
require "active_record"
require 'yaml'

Dir[File.expand_path('../../app/models', __FILE__) << '/*.rb'].each do |file|
  require file
end
config = YAML.load_file('./config/database.yml')
ActiveRecord::Base.establish_connection(config['development'])

Slack.configure do |conf|
  # 先ほど控えておいたAPI Tokenをセット
  conf.token = 'xoxb-121387490661-RkDYrGCVQRrOWMxHzj4kRbkh'
end

# RTM Clientのインスタンスを生成
client = Slack::RealTime::Client.new

# hello eventを受け取った時の処理
client.on :hello do
  puts 'connected!'
  client.message channel: "C3KV3TLH5", text: "Welcome to engineer quiz channel!!\nこのchannelでは少しでも早く、多くのFincエンジニアの名前を覚えてもらうために\nランダムで社員、インターン生の写真から名前を当ててもらうクイズが作成されてます\nそれでは *start* で始めましょう!!"
end

# message eventを受け取った時の処理
client.on :message do |data|
  case data['text']
  when 'kakiku' then
    client.message channel: data['channel'], text: 'bbbbbb'
  when 'shop' then
    class Shop < ActiveRecord::Base
      p Shop.all
    end
    client.message channel: data['channel'], text: 'kkakiku'
  when 'start' then
    class Engineer < ActiveRecord::Base
      @engineer = Engineer.first.image
      p @engineer
    end
    p data
    @answer = Engineer.order("RAND()").first
    client.message channel: data['channel'],
    text: "#{@answer.image}"
    client.on :message do |data2|
      if data2['text'] === "#{@answer.nickname}"
        client.message channel: data2['channel'], text: '正解！'
        break
      end
      if data2['text'] != "#{@answer.nickname}" && data2['text'] != data['text'] && data2['subtype'] != 'bot_message' && data2['text'] != nil && data2['text'] != 'start'
        client.message channel: data2['channel'], text: '残念！あと1回しか間違えられないよ!!'
        client.on :message do |data3|
          if data3['text'] == "#{@answer.nickname}"
            client.message channel: data3['channel'], text: '正解っす!!'
            break
          elsif data3['text'] != "#{@answer.nickname}" && data3['text'] != data2['text'] && data3['subtype'] != 'bot_message' && data3['text'] != nil && data3['text'] != 'start'
            client.message channel: data3['channel'], text: '残念！5回タイプして覚えよう!!正解は"#{@answer.nickname}"さんでした'
            break
          end
        end
        break
      end
    end
  end
end

# Slackに接続
client.start!
