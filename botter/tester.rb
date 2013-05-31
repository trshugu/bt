#!ruby
# coding: utf-8
require 'twitter'

lineArray = Array.new()
File.readlines("testoauth.txt").each do |line|
  lineArray.push line
end

Twitter.configure do |c|
  c.consumer_key = lineArray[0].chomp
  c.consumer_secret = lineArray[1].chomp
  c.oauth_token = lineArray[2].chomp
  c.oauth_token_secret = lineArray[3].chomp
end

=begin
=end

tweet = "test" + rand(1000).to_s
#puts tweet
#Twitter.update(tweet)

#・フォローを取得する
#・リプライを取得する




=begin
=end



# TLfirst取得
first_time_line = Twitter.home_timeline[0]
# 自分でない
if (first_time_line.user.name != "trstester")
  # 正規表現で目的の文字列の存在確認
  regex = first_time_line.text
  #if regex[/く\s+た\s+び\s+れ/]
  if regex[/test/]
    puts "find"
    # @name取得
    puts "@" + first_time_line.user.name + " 某"
    Twitter.update("@" + first_time_line.user.name + " 某")
  else
    puts "not"
  end
end

#puts Twitter.home_timeline[0]
#puts Twitter.home_timeline[0].name



=begin
# 応用：フォロワー数 フォロー数
puts Twitter.follower_ids("trstester").ids.size
puts Twitter.friend_ids("trstester").ids.size
=end

=begin
# 指定ユーザーのフォロワーのID取得
#p Twitter.follower_ids("trstester")

# 指定ユーザーのフォローID取得
#p Twitter.friend_ids("agileronin")
=end


=begin
# 指定ユーザーの情報取得
p Twitter.user("trstester")
=end

=begin
#自分宛てのReplyの取得
p Twitter.mentions
p Twitter.mentions[0].text
=end


=begin
#自分のタイムラインの取得
puts Twitter.home_timeline[0].text
=end

=begin
# 指定ユーザーのタイムライン取得
Twitter.user_timeline("trstester").each do |aaa|
  p aaa.text
end

# 指定ユーザのタイムラインを取得
p Twitter.user_timeline("trstester")[0].text
=end


