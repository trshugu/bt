#!ruby
# coding: utf-8
=begin
=end

require 'sinatra'
require "sinatra/reloader" if development?
require 'thin'
require 'digest/md5'

get '/db/:id' do
  # 重さを表現するためにsleep
  sleep 0.25
  
  # idを元にダイジェストを作成
  digest = Digest::MD5.hexdigest(params[:id])
  
  # ダイジェストを並べて2Mくらいにする→メモリリーク発生のため小さ目に
  result = ""
  #50000.times.each{
  5.times.each{
    result << digest
  }
  
  return result
end

