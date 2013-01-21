#!ruby
# coding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'twitter'
require 'assets/betweenhour'

class Bot
  def initialize
    # 認証設定
    lineArray = Array.new()
    File.readlines(File.dirname(__FILE__) + "/assets/oauth.txt").each do |line|
      lineArray.push line
    end
    
    @twit = Twitter
    @twit.configure do |c|
      c.consumer_key = lineArray[0].chomp
      c.consumer_secret = lineArray[1].chomp
      c.oauth_token = lineArray[2].chomp
      c.oauth_token_secret = lineArray[3].chomp
    end
  end
  
  def getTwitter
    return Twitter
  end
  
  # 特定の時間帯は発言しない(0時～7時)
  def isSleeping(hour)
    verifySleeping = BetweenHour.new
    
    if (verifySleeping.isBetweenHour(0, 7, hour) == false)
      return true
    else
      return false
    end
  end
  
  # ランダムに一行取得
  def getRandomOneline(path)
    filelinecount = File.open(path).read.count("\n") + 1
    oneline = File.open(path).readlines[rand(filelinecount)].chomp
    
    return oneline
  end
  
  def getList
    return getRandomOneline(File.dirname(__FILE__) + "/assets/list.txt")
  end
  
  def getApocalypse
    apocalypse = getRandomOneline(File.dirname(__FILE__) + "/assets/apocalypse.txt") + "━黙示録" + rand(1000).to_s + "章━"
    puts apocalypse
    return apocalypse.force_encoding("UTF-8")
  end
  
  def getTabisaki
    return "そうだ。" + getRandomOneline(File.dirname(__FILE__) + "/assets/list_place.txt") + "行こう"
  end
end

#tt = Bot.new.getTwitter
#tt.update("test!!")