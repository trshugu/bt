#!ruby
# -*- coding: utf-8 -*-
=begin
=end

require 'rspec'
require './betweenhourV2'

describe BetweenHour do
  before do
    @bhTest = BetweenHour.new
  end
  
  it "1 ある時刻と、時間の範囲(開始時刻と終了時刻)を受け取る。" do
    @bhTest.isBetweenHour(1,1,1).should_not be_nil
  end
  
  it "2 時刻は、6時であれば6のような指定でよく、分単位は問わない。" do
    proc {@bhTest.isBetweenHour(1,1,1)}.should_not raise_error
    proc {@bhTest.isBetweenHour(1,"b","c")}.should raise_error(RuntimeError)
    proc {@bhTest.isBetweenHour("a",1,"c")}.should raise_error(RuntimeError)
    proc {@bhTest.isBetweenHour("a","b",1)}.should raise_error(RuntimeError)
  end
  
  it "3 範囲指定は、開始時刻を含み、終了時刻は含まないと判断すること。" do
    @bhTest.isBetweenHour(1,3,0).should be_false
    @bhTest.isBetweenHour(1,3,1).should be_true
    @bhTest.isBetweenHour(1,3,2).should be_true
    @bhTest.isBetweenHour(1,3,3).should be_false
  end
  
  it "4 ただし開始時刻と終了時刻が同じ場合は含むと判断すること。" do
    @bhTest.isBetweenHour(0,0,0).should be_true
    @bhTest.isBetweenHour(0,0,1).should be_false
    @bhTest.isBetweenHour(20,20,20).should be_true
    @bhTest.isBetweenHour(20,20,21).should be_false
    @bhTest.isBetweenHour(23,23,22).should be_false
    @bhTest.isBetweenHour(23,23,23).should be_true
  end
  
  it "5 開始時刻が22時で終了時刻が5時、というような指定をされても動作すること。" do
    @bhTest.isBetweenHour(23,1,22).should be_false
    @bhTest.isBetweenHour(23,1,23).should be_true
    @bhTest.isBetweenHour(23,1,0).should be_true
    @bhTest.isBetweenHour(23,1,1).should be_false
  end
  
  it "testTriargument" do
    @bhTest.isBetweenHour(0,4,23).should be_false
    @bhTest.isBetweenHour(0,4,0).should be_true
    @bhTest.isBetweenHour(0,4,1).should be_true
    @bhTest.isBetweenHour(0,4,3).should be_true
    @bhTest.isBetweenHour(0,4,4).should be_false
    @bhTest.isBetweenHour(0,4,5).should be_false
    
    @bhTest.isBetweenHour(21,23,21).should be_true
    @bhTest.isBetweenHour(21,23,22).should be_true
    @bhTest.isBetweenHour(21,23,23).should be_false
    @bhTest.isBetweenHour(21,23,0).should be_false
    
    @bhTest.isBetweenHour(2,1,2).should be_true
    @bhTest.isBetweenHour(2,1,1).should be_false
    @bhTest.isBetweenHour(2,1,0).should be_true
    @bhTest.isBetweenHour(23,0,23).should be_true
    @bhTest.isBetweenHour(23,0,0).should be_false
    @bhTest.isBetweenHour(23,0,10).should be_false
  end
  
  it "testException" do
    proc {@bhTest.isBetweenHour(21,23,24)}.should raise_error(RuntimeError)
    proc {@bhTest.isBetweenHour(30,0,0)}.should raise_error(RuntimeError)
    proc {@bhTest.isBetweenHour(1,100,1)}.should raise_error(RuntimeError)
    proc {@bhTest.isBetweenHour(22,-1,3)}.should raise_error(RuntimeError)
    proc {@bhTest.isBetweenHour(-23,1,3)}.should raise_error(RuntimeError)
    proc {@bhTest.isBetweenHour(22,1,-128)}.should raise_error(RuntimeError)
  end
end


