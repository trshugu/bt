#!ruby
# -*- coding: utf-8 -*-

require "net/http"
require "uri"

# URIチェック(スレッド化され並列処理される)
class Checklink
  def checkuri(uri)
    return "a"
  end
end