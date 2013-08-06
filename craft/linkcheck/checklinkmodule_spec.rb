#!ruby
# -*- coding: utf-8 -*-

require 'rspec'
require './checklinkmodule'

describe Checklink, "が" do
  before do
    @cl = Checklink.new
  end

  it "正常の場合" do
    notfoundurl = "http://www.yahoo.co.jp/"
    result = @cl.checkuri(notfoundurl)
    result.should == nil
  end

  it "404の場合" do
    notfoundurl = "http://www.yahoo.co.jp/naiyon.html"
    result = @cl.checkuri(notfoundurl)
    result.chomp.should == notfoundurl + " 404"
  end
  
  it "例外の場合" do
    raiseurl = "http://anoie.dinoe.doijo"
    result = @cl.checkuri(raiseurl)
    result.chomp.should == raiseurl + " 例外"
  end
end
