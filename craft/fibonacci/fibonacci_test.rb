require 'test/unit'
require './fibonacci'

class TestFibonacci < Test::Unit::TestCase
  def setup
    @fbTest = Fibonacci.new
  end
  
  def testIntin
    assert_equal(1,@fbTest.returnFibonacciNumber(0))
    assert_equal(1,@fbTest.returnFibonacciNumber(1))
    assert_equal(2,@fbTest.returnFibonacciNumber(2))
    assert_equal(3,@fbTest.returnFibonacciNumber(3))
    assert_equal(5,@fbTest.returnFibonacciNumber(4))
    assert_equal(8,@fbTest.returnFibonacciNumber(5))
    assert_equal(13,@fbTest.returnFibonacciNumber(6))
  end
  
  def testStress
    1000.times do |count|
      @fbTest.returnFibonacciNumber(count)
    end
  end
  
  def testException
    assert_raise(RuntimeError){@fbTest.returnFibonacciNumber("0")}
    assert_raise(RuntimeError){@fbTest.returnFibonacciNumber("b")}
  end
end
