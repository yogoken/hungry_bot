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
  conf.token = 'xoxb-121387490661-trbXKpDNblw6IsoLMEZixu5j'
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
    @answer = Engineer.order("RAND()").first
    client.message channel: data['channel'],
    text: "#{@answer.image}"
    client.on :message do |data2|
      if data2['text'] === "#{@answer.nickname}"
        client.message channel: data2['channel'], text: '正解！'
        break
      end
      if data2['text'] != "#{@answer.nickname}" && data2['text'] != data['text'] && data2['subtype'] != 'bot_message' && data2['text'] != nil
        client.message channel: data2['channel'], text: '残念！'
        break
      end
    end
  end
end

# Slackに接続
client.start!
