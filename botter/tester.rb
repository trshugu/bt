#!ruby
# -*- coding: utf-8 -*-
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

tweet = "test" + rand(100).to_s
#Twitter.update(tweet)

#・フォローを取得する
#・リプライを取得する




=begin
=end








=begin
# 応用：フォロワー数 フォロー数
puts Twitter.follower_ids("agileronin").ids.size
puts Twitter.friend_ids("agileronin").ids.size
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


