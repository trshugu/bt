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
    url = "http://www.yahoo.co.jp/"
    result = check_uri(url)
    result.should == nil
    #result.chomp.should == url + " 200"
  end

  it "404の場合" do
    url = "http://www.yahoo.co.jp/naiyon.html"
    result = check_uri(url)
    result.chomp.should == url + " 404"
  end
  
  it "例外の場合" do
    url = "http://anoie.dinoe.doijo"
    result = check_uri(url)
    result.chomp.should == url + " 例外"
  end
  
  it "リダイレクト→正常の場合" do
    url = "http://yahoo.co.jp/"
    #locationurl = "http://www.yahoo.co.jp/"
    result = check_uri(url)
    #result.chomp.should == locationurl + " 200"
    result.should == nil
  end
end
