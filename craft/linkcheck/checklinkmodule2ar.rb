#!ruby
# -*- coding: utf-8 -*-

require "net/http"
require "uri"

# URIチェック(スレッド化され並列処理される)
class Checklink
  def checkuri(uri)
    begin
      response = Net::HTTP.get_response(URI.parse(uri))
      return response.code.to_s
    rescue Exception => e
      return "Exeption"
    end
  end
end
