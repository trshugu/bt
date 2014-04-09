#!ruby
# coding: utf-8
=begin
=end

# require 'test/unit'

require 'minitest/unit'
require './tmp'

MiniTest::Unit.autorun








=begin
# ModelAPIの作成
require 'rack/test'

class TestApi < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  def testResponse
    get '/'
    assert last_response.ok?
    assert_equal 'done', last_response.body
  end
  
  def testQuery
    get '/?aaa=bbb'
    assert last_response.ok?
    assert_equal 'donebbb', last_response.body
  end
  
  def testWriteFile
    expect = "testwrite"
    get "/write/" + expect
    assert last_response.ok?
    assert_equal 'done', last_response.body
    
    assert_equal expect, File::open("api.txt", "r").read
  end
  
  def testSinaGet
    get "/sina/"
    assert last_response.ok?
    assert_equal 'sina', last_response.body
  end
  
  def testSinaGetId
    get "/sina/:id"
    assert last_response.ok?
    assert_equal 'sina', last_response.body
  end
  
  def testSinaPost
    post "/sina/"
    assert last_response.ok?
    assert_equal 'done', last_response.body
    
    assert_equal "sina", File::open("sina.txt", "r").read
  end
  
  def testSinaPostId
    post "/sina/", :id=>"aaa"
    assert last_response.ok?
    assert_equal 'done', last_response.body
    
    assert_equal "sina", File::open("sina.txt", "r").read
  end
  
  def testSinaPut
    put "/sina/"
    assert last_response.ok?
    assert_equal 'done', last_response.body
    
    assert_equal "sina", File::open("sina.txt", "r").read
  end
  
  def testSinaDelete
    delete "/sina/"
    assert last_response.ok?
    assert_equal 'done', last_response.body
    
    assert_equal "sina", File::open("sina.txt", "r").read
  end
  
  def testSinaOption
    options "/sina/"
    assert last_response.ok?
    assert_equal 'done', last_response.body
  end
end
=end



=begin
# specにおける日本語での記述に関する応用
class Object
  def current_method
    # 文字変換含む
    caller.first.encode(Encoding::Windows_31J).scan(/`(.*)'/).to_s
  end
end

class TestNihongo < MiniTest::Unit::TestCase
  def testあのくたらさんみゃくさんぼだい
    puts self.class.name
    puts current_method
    assert_equal 1,1
  end
end
=end



=begin
class TestKalk < MiniTest::Unit::TestCase
  def testOperator
    assert_equal(11, Kalk(6, 3, Operator::Plus) )
    assert_equal(1, Kalk(6, 3, Operator::Minus) )
    assert_equal(30, Kalk(6, 3, Operator::Multiplication) )
    assert_equal(1, Kalk(6, 3, Operator::Division) )
  end
  
  def testAbsolute
    assert_equal(1, Kalk(2, 4, Operator::Minus) )
    assert_equal(1, Kalk(4, 2, Operator::Minus) )
  end
  
  
end
=end

=begin
class TestRb < Test::Unit::TestCase
  def setup
    @left = Place.new(3, 3)
    @right = Place.new(1, 3)
  end

  def testCheckState
    assert_equal(true, check_state(@left))
    assert_equal(false, check_state(@right))
  end
  
  def testMove
    
  end
  
end
=end


=begin
class TestBetweenHour < Test::Unit::TestCase
  def testGetargs
    assert_not_nil(@bhTest.isBetweenHour(1,1,1))
  end
end
=end



=begin
#MF試験問題テスト
require 'test/unit'
require './tmp'

class TestBetweenHour < Test::Unit::TestCase
  def setup
    @bhTest = BetweenHour.new
  end
  # 1 ある時刻と、時間の範囲(開始時刻と終了時刻)を受け取る。
  def testGetargs
    assert_not_nil(@bhTest.isBetweenHour(1,1,1))
  end
  
  # 2 時刻は、6時であれば6のような指定でよく、分単位は問わない。
  def testSetInt
    assert_nothing_raised(){@bhTest.isBetweenHour(1,1,1)}
    assert_raise(RuntimeError){@bhTest.isBetweenHour(1,"b","c")}
    assert_raise(RuntimeError){@bhTest.isBetweenHour("a",1,"c")}
    assert_raise(RuntimeError){@bhTest.isBetweenHour("a","b",1)}
  end
  
  # 3 範囲指定は、開始時刻を含み、終了時刻は含まないと判断すること。
  def testContainsStarttimeNotIncludeEndtime
    assert_equal(false,@bhTest.isBetweenHour(1,3,0))
    assert_equal(true,@bhTest.isBetweenHour(1,3,1))
    assert_equal(true,@bhTest.isBetweenHour(1,3,2))
    assert_equal(false,@bhTest.isBetweenHour(1,3,3))
  end
  
  # 4 ただし開始時刻と終了時刻が同じ場合は含むと判断すること。
  def testSameInbludeBoth
    assert_equal(true,@bhTest.isBetweenHour(0,0,0))
    assert_equal(false,@bhTest.isBetweenHour(0,0,1))
    assert_equal(true,@bhTest.isBetweenHour(20,20,20))
    assert_equal(false,@bhTest.isBetweenHour(20,20,21))
    assert_equal(false,@bhTest.isBetweenHour(23,23,22))
    assert_equal(true,@bhTest.isBetweenHour(23,23,23))
  end
  
  # 5 開始時刻が22時で終了時刻が5時、というような指定をされても動作すること。
  def testOverDay
    assert_equal(false,@bhTest.isBetweenHour(23,1,22))
    assert_equal(true,@bhTest.isBetweenHour(23,1,23))
    assert_equal(true,@bhTest.isBetweenHour(23,1,0))
    assert_equal(false,@bhTest.isBetweenHour(23,1,1))
  end
  
  def testTriargument
    assert_equal(false,@bhTest.isBetweenHour(0,4,23))
    assert_equal(true,@bhTest.isBetweenHour(0,4,0))
    assert_equal(true,@bhTest.isBetweenHour(0,4,1))
    assert_equal(true,@bhTest.isBetweenHour(0,4,3))
    assert_equal(false,@bhTest.isBetweenHour(0,4,4))
    assert_equal(false,@bhTest.isBetweenHour(0,4,5))
    
    assert_equal(true,@bhTest.isBetweenHour(21,23,21))
    assert_equal(true,@bhTest.isBetweenHour(21,23,22))
    assert_equal(false,@bhTest.isBetweenHour(21,23,23))
    assert_equal(false,@bhTest.isBetweenHour(21,23,0))
    
    assert_equal(true,@bhTest.isBetweenHour(2,1,2))
    assert_equal(false,@bhTest.isBetweenHour(2,1,1))
    assert_equal(true,@bhTest.isBetweenHour(2,1,0))
    assert_equal(true,@bhTest.isBetweenHour(23,0,23))
    assert_equal(false,@bhTest.isBetweenHour(23,0,0))
    assert_equal(false,@bhTest.isBetweenHour(23,0,10))
  end

  def testException
    assert_raise(RuntimeError){@bhTest.isBetweenHour(21,23,24)}
    assert_raise(RuntimeError){@bhTest.isBetweenHour(30,0,0)}
    assert_raise(RuntimeError){@bhTest.isBetweenHour(1,100,1)}
    assert_raise(ArgumentError){@bhTest.isBetweenHour(22,-1,3)}
    assert_raise(ArgumentError){@bhTest.isBetweenHour(-23,1,3)}
    assert_raise(ArgumentError){@bhTest.isBetweenHour(22,1,-128)}
  end
end
=end


=begin
require 'test/unit'

#$:.unshift File.dirname(__FILE__)  # ロードパスにカレントディレクトリを追加
#require 'tmp'

require './tmp'

class Anokutara < Test::Unit::TestCase
  # 接頭辞がtestでないとうまく反応しない
  def testGetXY()
    point = Tmp.new(3, 4)
    assert_equal(3, point.getX())
    assert_equal(4, point.getY())
  end
    
  def testSannmyaku()
    point = Tmp.new(3, 4)
    point.san(3)
    assert_equal(3, point.getsan())
  end
end
=end

