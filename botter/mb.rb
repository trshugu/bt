#!ruby
# -*- coding: utf-8 -*-
require 'twitter'

lineArray = Array.new()
File.readlines("oauth.txt").each do |line|
  lineArray.push line
end

Twitter.configure do |c|
  c.consumer_key = lineArray[0].chomp
  c.consumer_secret = lineArray[1].chomp
  c.oauth_token = lineArray[2].chomp
  c.oauth_token_secret = lineArray[3].chomp
end

=begin
tweet = "test" + rand(100).to_s
loop do
  Twitter.update(tweet)
end
=end

tweet = "test"
Twitter.update(tweet)
