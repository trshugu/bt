require 'test/unit'
require './betweenhourV2'

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
    assert_raise(RuntimeError){@bhTest.isBetweenHour(22,-1,3)}
    assert_raise(RuntimeError){@bhTest.isBetweenHour(-23,1,3)}
    assert_raise(RuntimeError){@bhTest.isBetweenHour(22,1,-128)}
  end
end
