#!ruby
# coding: utf-8

require 'rubygems'
require 'sinatra'
require "active_support/core_ext"

set :port, 4568

# ユーザ仮データ 
user = {
  "i0001" => {:name => 1, :food => "お米"},
  "i0002" => {:name => "user2", :food => "みかん"},
  "i0003" => {:name => "user3", :food => "昆布"},
  "i0004" => {:name => "user4", :food => "ゆで玉子"},
  "i0005" => {:name => "user5", :food => "納豆"},
}

get '/' do
  content_type :xml
  user.to_xml(:root => "recommends", :skip_types => true)
end

get '/.json' do
  content_type :json
  user.to_json(:root => "recommends")
end

get '/user/:id' do
  if user[params[:id]]
    content_type :xml
    @user_name = user[params[:id]][:name] 
    @user_food = user[params[:id]][:food]
    erb :getuser
  else
    "ID:#{params[:id]}はありません。"
  end
end


post '/' do
  erb %{
    <span>POSTテスト</span>
  }
end

put '/' do
  erb %{
    <span>PUTテスト</span>
  }
end

delete '/' do
  erb %{
    <span>DELETEテスト</span>
  }
end
