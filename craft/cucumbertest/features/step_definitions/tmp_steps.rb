# coding:utf-8
# language: ja

require "./tmp.rb"

Then /^クラスをNEW$/ do
  @a = Ctest.new
end

Then /^メソッドよびだして(\w+)のとき$/ do |arg|
  @res = @a.ccc(arg)
end

Then /^(\w+)addへんきゃく$/ do |arg|
  puts @res
  @res == arg + "add"
end

