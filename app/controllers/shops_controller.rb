class ShopsController < ApplicationController
  def create
    @shop = Shop.new(shop_params)
    notify_to_slack if @shop.save
  end

  private

  def notify_to_slack
    text = <<-EOC
    --------------------------------
      [#{Rails.env}] 新しい意見が来ました。
      ▽ショップ名
      #{shop.name}
      ▽URL
      #{shop.url}
    EOC
    Slack.chat_postMessage text: text, username: "Assistant", channel: "#hungry_bot"
  end

  def shop_params
    params.require(:shop).permit(:name, :url)
  end
end
