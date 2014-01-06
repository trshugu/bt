#!ruby
# coding: utf-8

require "net/http"

# URIチェック(スレッド化され並列処理される)
module Checklink
  def check_uri(uri, recursive = false)
    begin
      parced_uri = URI.parse(uri)
      response = Net::HTTP.get_response(parced_uri)
      
      case response
        when Net::HTTPSuccess
          return nil
          #return uri + " " + response.code.to_s + "\n"
          
        when Net::HTTPMovedPermanently
        when Net::HTTPFound
          if recursive
            return uri + " too deep " + "\n"
          else
            if response["location"][/^http/]
              return check_uri( response["location"], true)
            else
              return check_uri( parced_uri.scheme + "://" + parced_uri.host + response["location"], true)
            end
          end
          
        else
          return uri + " " + response.code.to_s + "\n"
          
      end
    rescue Exception => e
      return uri + " 例外\n"
    end
  end
  
  def redirect_check(uri)
    
  end
end
