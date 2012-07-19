#!ruby
# -*- coding: utf-8 -*-
=begin
=end

require 'rspec'
require './tmp'

describe Tmp, "が" do
  it "クラス内で" do
    uuu = Tmp.new
    uuu.str.should == "TmpOut"
  end
  
  it "ワンライナーの場合" do
    Tmp.new.str.should == "TmpOut"
  end
end




=begin
describe Tmp, "when empty" do
  before do
    @empty_array = []
  end

  it "should be empty" do
    @empty_array.should be_empty
  end

  it "should size 0" do
    @empty_array.size.should == 0
  end

  after do
    @empty_array = nil
  end
end
=end


