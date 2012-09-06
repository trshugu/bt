#!ruby
# -*- coding: utf-8 -*-
=begin
=end

require 'rspec'
require './tmp'



=begin
describe Tmp, "が" do
  it "404の場合" do
    # 404
    notfoundurl = "http://www.yahoo.co.jp/naiyon.html"
    
    tmp = Tmp.new
    result = tmp.checkuri(notfoundurl)
    
    result.chomp.should == notfoundurl + " 404"
    
    #uuu.str.should == "TmpOut"
  end
  
  it "例外の場合" do
    # 例外
    raiseurl = "http://anoie.dinoe.doijo"
    
    tmp = Tmp.new
    result = tmp.checkuri(raiseurl)
    
    result.chomp.should == raiseurl + " 例外"

    #Tmp.new.str.should == "TmpOut"
  end
end
=end


=begin
describe Tmp, "が" do
  it "クラス内で" do
    uuu = Tmp.new
    uuu.str.should == "TmpOut"
  end
  
  it "ワンライナーの場合" do
    Tmp.new.str.should == "TmpOut"
  end
end
=end


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


