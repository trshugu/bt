#!ruby
# coding: utf-8
=begin
=end

# require 'test/unit'

require 'minitest/unit'
require './web'
require './db'
require 'digest/md5'

MiniTest::Unit.autorun

require 'rack/test'

class TestApi < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  def testWeb
    get '/web/50'
    assert last_response.ok?
    assert_equal '50res', last_response.body
  end
  
  def testDb
    get '/db/2'
    assert last_response.ok?
    #assert_equal '2', last_response.body
  end

  def testModelDigest
    get '/db/digest'
    assert last_response.ok?
    digest = Digest::MD5.hexdigest("digest")
    result = ""
    50000.times.each{
      result << digest
    }
    assert_equal result, last_response.body
  end
  
  def testWebDigest
    get '/web/digest'
    assert last_response.ok?
    digest = Digest::MD5.hexdigest("digest")
    result = ""
    50000.times.each{
      result << digest
    }
    assert_equal result, last_response.body
  end
  
end



