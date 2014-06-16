#!ruby
# coding: utf-8
=begin
=end

require 'sinatra'
require "sinatra/reloader" if development?
require 'thin'
require "json"
require "rack/cache"
require "net/http"
require "uri"
require "redis"

# 返却する値そのものをキャッシュしてしまったのでsinatraキャッシュは不採用
#use Rack::Cache,
#  :verbose     => true

@@id_cache = []
#@@cache_time = 0

get '/web/cache_refresh' do
  @@id_cache = []
end

def DbAccess(params)
  uri =  URI.parse("http://:4567/db/"  + params[:id])
  res = Net::HTTP.get_response(uri)
  body = res.body if res.is_a?(Net::HTTPSuccess)
  
  body
end

get '/web/:id' do
  starttime = Time.now
  # 60秒キャッシュ
  #cache_control :public, :max_age => 60
  #return @@id_cache.shuffle!.pop if @@id_cache && @@id_cache.size != 0 && (Time.now.to_i - @@cache_time) < 60
  
  # idがなかったらDbAccess
  unless @@id_cache.include?(params[:id])
    DbAccess(params)
    
    # キャッシュ
    @@id_cache.push(params[:id])
  end
  
  # ミリ秒を返す
  endtime = Time.now
  return ((endtime - starttime) * 1000).to_i.to_s
end

redis = Redis.new(:host => "aws.com")

get '/web-redis/:id' do
  starttime = Time.now
  #redis = Redis.new(:host => "127.0.0.1")
  
  body = redis.get params[:id]
  if body == nil
    puts "miss"
  else
    puts "find"
  end
  
  if body == nil
    uri =  URI.parse("http://:4567/db/"  + params[:id])
    res = Net::HTTP.get_response(uri)
    body = res.body if res.is_a?(Net::HTTPSuccess)  
    redis.set(params[:id], body)
    redis.expire(params[:id], 300)
  end
  
  body
  
  # ミリ秒を返す
  endtime = Time.now
  return ((endtime - starttime) * 1000).to_i.to_s
end

