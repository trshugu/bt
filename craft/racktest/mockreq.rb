# coding: utf-8

require './tmp.rb'
require 'test/unit'
require 'rack/mock'

class RackAppTest < Test::Unit::TestCase
  def setup
    @app = RackApp.new
    @mr  = Rack::MockRequest.new(@app)
  end

  def test_get
    res = nil
    assert_nothing_raised('なんか失敗した') { res = @mr.get('/', :lint => true) }
    assert_not_nil res, 'レスポンス来てない'
    assert_equal 200, res.status, 'ステータスコードが変'
    assert_equal 'text/html;charset=utf-8', res['Content-Type'], 'Content-Typeが変'
    assert_match /loook？/, res.body, '本文が変'
  end

  def test_post
    res = nil
    assert_nothing_raised('なんか失敗した') { res = @mr.post('/', :lint => true) }
    assert_not_nil res, 'レスポンス来てない'
    assert_equal 200, res.status, 'ステータスコードが変'
    assert_equal 'text/html;charset=utf-8', res['Content-Type'], 'Content-Typeが変'
    assert_match /baboon/, res.body, '本文が変'
  end
end
