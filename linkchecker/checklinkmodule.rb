#!ruby
# -*- coding: utf-8 -*-

require "net/http"
require "uri"

# URIチェック(スレッド化され並列処理される)
class Checklink
  def checkuri(uri)
    begin
      response = Net::HTTP.get_response(URI.parse(uri))
      case response
        when Net::HTTPSuccess, Net::HTTPRedirection
          return
          # return uri + " " + response.code.to_s + "\n"
        else
          return uri + " " + response.code.to_s + "\n"
      end
    rescue Exception => e
      return uri + " 例外\n"
    end
  end
end
