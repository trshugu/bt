#!ruby
# -*- coding: utf-8 -*-
require 'twitter'

lineArray = Array.new()
File.readlines("maroauth.txt").each do |line|
  lineArray.push line
end

Twitter.configure do |c|
  c.consumer_key = lineArray[0].chomp
  c.consumer_secret = lineArray[1].chomp
  c.oauth_token = lineArray[2].chomp
  c.oauth_token_secret = lineArray[3].chomp
end

tweet = "test"
loop do
  Twitter.update(tweet)
  sleep 43200
end
