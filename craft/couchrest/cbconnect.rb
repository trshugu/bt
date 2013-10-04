#!ruby
# coding: utf-8

# Couchbaseとの接続を行う

require 'couchbase'

def connect_cb
  conn = Couchbase.connect(:bucket => "recommend", :hostname => "192.168.xx.xx", :username => 'user', :password => 'pass')
  return conn
end
