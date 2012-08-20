#!ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'

=begin
このアプリケーションは，4つのメソッド呼び出しでできています。
即ち，helpers，template，get，postメソッドです
=end

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

template :layout do
  "<html><body><h1>Hello World</h1><%= yield %></body></html>"
end

get '/' do
  erb %{
    <p>あなたの名前は？</p>
    <form action='/' method='POST'>
    <input type='text' name='name'>
    <input type='submit' value='送信'>
    </form>
  }
end
# postの/がないのでエラーになる。
post '/hello' do
  erb %{
    <p>こんにちは，<%= h params[:name] %>さん！</p>
    <a href='/'>戻る</a>
  }
end
