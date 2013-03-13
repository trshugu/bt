#!ruby
# coding: utf-8

require 'rubygems'
require 'sinatra'
require 'atomutil'

username = ''
password = ''

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

template :layout do
  "<html><body><%= yield %></body></html>"
end

get '/' do
  erb %{
    <form action='/' method='POST'>
    <textarea name="desc" rows="4" cols="40"></textarea><br>
    <input type='submit' value='sub'>
    </form>
  }
end

post '/' do
  auth = Atompub::Auth::Wsse.new :username => username, :password => password
  client = Atompub::Client.new :auth => auth
  collection_uri = 'http://d.hatena.ne.jp/%s/atom/blog' % username
  
  #title = params[:title]
  #content = params[:desc]
  title = ""
  content = ""
  firstflg = true
  params[:desc].each_line {|line|
    if firstflg
      title = line
      firstflg = false
    else
     content << line
    end
  }
  
  entry = Atom::Entry.new
  entry.title = title.encode('BINARY', 'BINARY')
  entry.content = content.encode('BINARY', 'BINARY')
  entry.updated = Time.now
  
  puts client.create_entry collection_uri, entry
  
  erb %{
    <form action='/' method='POST'>
    <textarea name="desc" rows="4" cols="40"></textarea><br>
    <input type='submit' value='sub'>
    </form>
  }
end
