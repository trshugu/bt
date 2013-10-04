#!ruby
# coding: utf-8

require "json"
require "net/http"

#uri = "http://localhost:8092/"
uri = "http://localhost:8092/beer-sample/_design/beer/_view/brewery_beers/"
#uri = "http://192.168.xx.xx:8092/beer-sample/_design/beer/_view/brewery_beers/"
starttime = Time.now
res = Net::HTTP.get_response(URI.parse(uri))
puts JSON.parse(res.body)["rows"][0]["key"][0]
endtime = Time.now
puts endtime - starttime
