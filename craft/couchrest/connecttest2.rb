#!ruby
# coding: utf-8

require 'couchbase'

starttime = Time.now
client = Couchbase.connect(:bucket => "beer-sample", :hostname => "localhost", :username => 'user', :password => 'pass')
#client = Couchbase.connect(:bucket => "beer-sample", :hostname => "192.168..", :username => 'user', :password => 'pass')
client.design_docs["beer"].brewery_beers.count
client.disconnect
endtime = Time.now
puts endtime - starttime
