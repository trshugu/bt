#!ruby
# coding: utf-8

require 'rubygems'
require 'sinatra'
require "active_support/core_ext"
require "json"

require './cbconnect'

set :port, 4568
set :environment, :production

# XMLモック
recommend_data = [
  {:muc_id => 33999746},
  {:muc_id => 32897269},
  {:muc_id => 33973985},
  {:muc_id => 32651484},
  {:muc_id => 32652094},
]



get '/recommend' do
  cb = connect_cb
  reco = cb.get("dummy")
  
  reco.each{|key, value|
    value.each{|v|
      recommend_data.push(:music_id => v)
    }
  }
  
  puts recommend_data
  content_type :xml
  recommend_data.to_xml(:root => "recommends", :skip_types => true)
end

get '/recommend.json' do
  content_type :json
  recommend_data.to_json(:root => "recommends")
end

get '/recommend/:id' do
  if recommend_data[params[:id]]
    content_type :xml
    @m_id = recommend_data[params[:id]][:music_id] 
    erb :outputformat
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
