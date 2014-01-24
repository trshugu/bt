#!ruby
# coding: utf-8

require 'rubygems'
require 'thin'
require 'eventmachine'
require 'sinatra'
require 'atomutil'
require 'twitter'
require 'slim'
require 'sass'


helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get "/css/responsive.css" do
  content_type 'text/css', :charset => 'utf-8'
  sass :"css/responsive"
end

get '/' do
  slim :index
end



post '/' do
  #auth = Atompub::Auth::Wsse.new :username => username, :password => password
  #client = Atompub::Client.new :auth => auth
  #collection_uri = 'http://d.hatena.ne.jp/%s/atom/blog' % username
  
  #title = params[:title]
  content = params[:desc]
  image = params[:im]
  #title = ""
  #content = ""
  #firstflg = true
  #params[:desc].each_line {|line|
  #  if firstflg
  #    title = line
  #    firstflg = false
  #  else
  #   content << line
  #  end
  #}
  
  
  slim :index
end
