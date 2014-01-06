#!ruby
# coding: utf-8

require 'rspec'
require './checklinkmodule'

describe Checklink, "が" do
  before do
    extend Checklink
    #@cl = Checklink.new
  end

  it "正常の場合" do
    notfoundurl = "http://www.yahoo.co.jp/"
    result = check_uri(notfoundurl)
    result.should == nil
    #result.chomp.should == notfoundurl + " 200"
  end

  it "404の場合" do
    notfoundurl = "http://www.yahoo.co.jp/naiyon.html"
    result = check_uri(notfoundurl)
    result.chomp.should == notfoundurl + " 404"
  end
  
  it "例外の場合" do
    raiseurl = "http://anoie.dinoe.doijo"
    result = check_uri(raiseurl)
    result.chomp.should == raiseurl + " 例外"
  end
  
  it "リダイレクトのチェック" do
    
  end
end
