require 'slack-ruby-client'

Slack.configure do |conf|
  # 先ほど控えておいたAPI Tokenをセット
  conf.token = 'xoxb-121387490661-FhhdaJcMunF6hQxWuf9XJ6PK'
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
  when '誰？' then
    client.message channel: data['channel'], text: "■名前\n余語憲太\n95年9月生まれ。明治大学3年(休学中 from 2016/10〜2017/10)\n■数ヶ月\n今年の3月頃、留学中にrubyを学び始める。
帰国して、2か月引きこもった挙句7月にTECH::CAMP受講、そこで主にadmin/営業やマーケが必要とする集計データ一覧画面をrailsで書いたり、Newspicksを目コピしたりとエセエンジニアとして活動。
とりあえずなんでもやるので宜しくお願いします!!"
  when '流れは？' then
    client.message channel: data['channel'], text: "
*残り4分のアジェンダ*
1:00 ~ この二日でやったこと
2:00 ~ 実際に真似しながら作った音声返答bot
3:00 ~ 率直な感想
4:00 ~ 作りたかったもの(hungrybot)"
  when '参考記事は？' then
    client.message channel: data['channel'], text: "```
■こんな僕でも30分でSlackのbotを作れた
http://lab.aratana.jp/entry/2014/12/04/185053

■ Slack Ruby Client
良記事→ https://blog.myon.info/blog/2016-01-24/slack-bot/
github: https://github.com/slack-ruby/slack-ruby-client

■ Slack Ruby Bot Server (今ここやってます)
github: https://github.com/slack-ruby/slack-ruby-bot-server

■ 先輩メンター 【ちゃんと声を出して返答してくれるbotをrubyで作ろう】
http://qiita.com/shizuma/items/ba0f51048d77db5f4f40
```
"
  when '感想は？' then
    client.message channel: data['channel'], text: "返答系はサクサクいくけど(ボットに話しかけて特定のことを返す)
DBから値を引っ張ってきてとか、ユーザーの情報をためておくとかが1日では学習できませんでした。"
  when '作りたかったものは？' then
    client.message channel: data['channel'], text: "github: https://github.com/yogoken/hungry_bot"
  end
end

# Slackに接続
client.start!
