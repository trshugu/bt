#!ruby
# coding: utf-8

require "net/http"
require "net/https"

# URIチェック(スレッド化され並列処理される)
module Checklink
  def check_uri(uri, recursive = 0)
    begin
      parced_uri = URI.parse(uri)
      http = Net::HTTP.new(parced_uri.host, parced_uri.port)
      http.use_ssl = (parced_uri.scheme == "https")
      path = (parced_uri.path == "") ? "/" : parced_uri.path
      path = (parced_uri.query) ? path + "?" + parced_uri.query : path
      response = http.request(Net::HTTP::Get.new(path))
      
      case response
        when Net::HTTPSuccess
          return nil
          #return uri + " " + response.code.to_s + "\n"
          
        when Net::HTTPRedirection
          if recursive > 20
            return uri + " too deep " + "\n"
          else
            if response["location"][/^http/]
              return check_uri( response["location"], recursive + 1)
            else
              return check_uri( parced_uri.scheme + "://" + parced_uri.host + response["location"], recursive + 1)
            end
          end
          
        else
          return uri + " " + response.code.to_s + "\n"
          
      end
    rescue Exception => e
      return uri + " 例外\n"
    end
  end
end
