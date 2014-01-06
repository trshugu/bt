#!ruby
# -*- coding: utf-8 -*-

require 'rspec'
require './checklinkmodule2ar'

describe Checklink, "が" do
  it "正常の場合" do
    notfoundurl = "http://www.yahoo.co.jp/"
    cl = Checklink.new
    
    result = cl.checkuri(notfoundurl)
    result.should == "200"
  end

  it "404の場合" do
    notfoundurl = "http://www.yahoo.co.jp/naiyon.html"
    cl = Checklink.new
    
    result = cl.checkuri(notfoundurl)
    result.chomp.should == "404"
  end
  
  it "例外の場合" do
    cl = Checklink.new
    
    raiseurl = "http://anoie.dinoe.doijo"
    result = cl.checkuri(raiseurl)
    
    result.chomp.should == "Exeption"
  end
end
