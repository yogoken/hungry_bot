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
  conf.token = 'xoxb-121387490661-eKLpQX2oswBnoiaAwJ7HXV52'
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
  when 'スタート' then
    class Engineer < ActiveRecord::Base
      @engineer = Engineer.first.image
      p @engineer
    end
    client.message channel: data['channel'],
    text: "#{Engineer.order("RAND()").first(1)[0].image}"
    client.on :message do |data2|
      num = 0
      while num < 1 do
        if data2['text'] == 'しげさん'
          p '正解'
          client.message channel: data2['channel'], text: '正解!!'
        else
          p '不正解'
          client.message channel: data2['channel'], text: '不正解!!'
        end
        num += 1
      end
    end
  end
end

# Slackに接続
client.start!
